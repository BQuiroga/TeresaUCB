require 'csv'
class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :posts, :dependent => :destroy
  has_many :group_managers, :dependent => :destroy
  has_many :groups, :dependent => :destroy
  has_one :personal_information, :dependent => :destroy
  has_one :resume, :dependent => :destroy
  has_one :company_information, :dependent => :destroy
  has_one :picture, :dependent => :destroy
  has_many :notifications, :dependent=> :destroy
  has_many :suggestions, :dependent => :destroy
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,:lockable

  validates :password, format:{ with: /\A(?=.*[a-z])(?=.*[A-Z])./, message: "o contraseña, debe contener por lo menos una mayúscula, una minúscula y un número"}
	after_create :send_admin_mail
  after_create :assign_default_role
  after_create :create_dependencies
  after_create :capit
  after_create :create_avatar
  def send_admin_mail
    UserMailer.welcome_email(self).deliver_now!
  end
  def is_secretary?
    has_role? :secretary
  end
  def is_company?
    has_role? :company
  end
  def is_administrator
    has_role? :administrator
  end
  def is_director
    has_role? :director
  end
  def is_student?
    has_role? :user
  end
  def capit
    self.name.capitalize!
    self.last_name.capitalize!
  end
  def role
    if is_company?
      return "Empresa"
    end
    if is_administrator
      return "Administrador"
    end
    if is_director
      return "Director de Carrera"
    end
    "Usuario"
  end
  def create_avatar
    Picture.create(:user_id=>self.id)
  end
  def create_dependencies
    Resume.create(:user_id => self.id)
    if self.is_company?
      CompanyInformation.create(:user_id=>self.id,:ciu_code_id=>1)
    else
      PersonalInformation.create(:user_id => self.id)
    end
  end
  def phone
    if is_company?
      self.company_information.phone
    else
      self.personal_information.call_center
    end
  end
  def contact_name
    self.company_information.contact_name
  end
  def is_in_this_group(grupo)
    mis_grupos=self.group_managers
    mis_grupos.where(group_id:grupo.id).size>0
  end
  def assign_default_role
    if company
      self.add_role(:company) if self.roles.blank?
    else
      self.add_role(:user) if self.roles.blank?
    end
  end

  def my_friend(other_id)
    Friendship.where(one:id,two:other_id)
  end
  def follows
    Follow.where(follower: id)
  end
  def follows_posts
    posts=[]
    follows.each do |follow|
      post=Post.where(user_id: follow.followed)
      posts=posts+post
    end
    posts
  end
  def searched_people_posts
    posts=[]
    searched= Searched.where(found: id)
		searched.each do |searching_company|
			post= Post.where(user_id: searching_company.searched_by,requiring:true)
			posts =posts +post
		end
    posts
  end
  def search(param)
    users=[]
    param.each do |criterio|
        user = User.where("name ~* ?",criterio)
        users = users+ user
        user = User.where("last_name ~* ?", criterio)
        users=users+user
    end
    users
  end
  def his_friend(other_id)
    Friendship.where(one:other_id,two:id)
  end
  def all_my_friends
    mine=Friendship.where(one:id)
    friends=[]
    mine.each do |friend|
      mine_friend=User.find(friend.two)
      friends=friends+[mine_friend]
    end
    their=Friendship.where(two:id)
    their.each do |friend|
      their_friend=User.find(friend.one)
      friends=friends=[their_friend]
    end
    friends.uniq
  end
  def my_friends_posts
    @posts=[]
    all_my_friends.each do |friend|
      @post=Post.where(user_id:friend.id)
      @posts=@posts+@post
    end
    @posts
  end
  def not_me(other_id)
    id!=other_id
  end
  def is_my_friend(other_id)
    my_friend(other_id).size>0 or his_friend(other_id).size>0
  end
  def is_my_group(group_id)
    Group.where(id:group_id,user_id:id).size>0
  end
  def unreaded_notifications
    self.notifications.where(readed:false)
  end
  def school_names
    resume.educations.map{|education| education.school_name}
  end
  def gender
    if personal_information
      return personal_information.gender_to_string
    end
  end
  def last_education_date
    educations=self.resume.educations
    last=Date.today
    educations.each do |edu|
      if last<edu.end_date
        last=edu.end_date
      end
    end
    last
  end
  def last_education
    educations=self.resume.educations
    last=Date.new(1940,10,10)
    ultima=0
    educations.each do |edu|
      if last<edu.end_date && edu.title!="Bachiller"
        last=edu.end_date
        ultima=edu.id
      end
    end
    if educations.size>0
      return Education.find(ultima)
    else
      return Education.new
    end
  end
  def not_company_users
    users=User.where(company:false)
  end
  def first_job_date
    jobs=self.resume.experiences
    first=Date.today
    jobs.each do |work|
      if first>work.start_date
        first=work.start_date
      end
    end
    first
  end
  def years_to_first_job
    res=Date.new
    if first_job_date>last_education_date
      res= (first_job_date - last_education_date).to_i
      resp=days_into_months(res)
    else
      if first_job_date==Date.today
        return -2
      else
        return -1
      end
    end
    resp
  end
  def time_work_users(list,time)
    resp=Array.new
    if time=="Aun no ha egresado"
      time=-1
    end
    if time=="Aún no trabaja"
      time=-2
    end
    list.each do |user|
      if (user.is_student? and !user.is_director and user.years_to_first_job==time)
        resp=resp+[user]
      end
    end
    resp.uniq
  end
  def days_into_months(some_date)
    some_date/30
  end
  def days_into_years(some_date)
    y=some_date/365
    m=(some_date%365)/30
    d=(some_date%365)%30
    y
  end
  def generate_xls_report(data,options={})
    column_names=["Titulo","Estudiantes Egresados"]
    CSV.generate(options) do |csv|
      csv << column_names
      data.each do |row|
        csv << row
      end
    end
  end
  def empresas
    User.where(company:true).size
  end

  #imagenes asociadas al perfil de usuario
  USERS = File.join Rails.root, 'public', 'image_store'
  after_save :guardar_imagen

    def image=(file_data)
      unless file_data.blank?
        @file_data = file_data
      end
    end
    def image_filename
      File.join USERS, "#{id}.jpg"
    end

    def image_path
      "/image_store/#{id}.jpg"
    end

    def has_image?
      File.exists? image_filename
    end

    private
    def guardar_imagen
      if @file_data
        FileUtils.mkdir_p USERS
        File.open(image_filename,'wb') do |f|
          f.write(@file_data.read)
        end
        @file_data=nil
      end
    end


end
