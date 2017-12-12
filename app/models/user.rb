class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :posts
  has_many :group_managers
  has_many :groups
  has_one :personal_information
  has_one :resume
  has_one :company_information
  has_many :notifications
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,:lockable

  validates :password, format:{ with: /\A(?=.*[a-z])(?=.*[A-Z])./, message: "o contraseña, debe contener por lo menos una mayúscula, una minúscula y un número"}
	after_create :send_admin_mail
  after_create :assign_default_role
  after_create :create_dependencies
  after_create :capit
  def send_admin_mail
    UserMailer.welcome_email(self).deliver_now!
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
  def create_dependencies
    Resume.create(:user_id => self.id)
    if self.is_company?
      CompanyInformation.create(:user_id=>self.id)
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
    personal_information.gender_to_string
  end
  def last_education_date
    educations=self.resume.educations
    last=Date.today
    educations.each do |edu|
      if last>edu.end_date
        last=edu.end_date
      end
    end
    last
  end
  def not_company_users
    users=User.where(company:false)
  end
  def first_job_date
    jobs=self.resume.experiences
    first=Date.today
    jobs.each do |work|
      if first>work.end_date
        first=work.end_date
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
      return -1
    end
    resp
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
end
