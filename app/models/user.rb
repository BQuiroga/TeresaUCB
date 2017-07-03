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
         :recoverable, :rememberable, :trackable, :validatable

  validates :password, format:{ with: /\A(?=.*[a-z])(?=.*[A-Z])./, message: "debe contener por lo menos una mayuscula, una minuscula y un numero"}
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
  def capit
    self.name.capitalize!
    self.last_name.capitalize!
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
    self.company_information.phone
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
        user = User.where(name: criterio)
        users = users+ user
        user = User.where(last_name: criterio)
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
end
