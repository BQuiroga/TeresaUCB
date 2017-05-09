class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :posts
  has_one :personal_information
  has_one :resume
  has_one :company_information
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :password, format:{ with: /\A(?=.*[a-z])(?=.*[A-Z])./, message: "must contain at least one uppercase letter, one lowercase letter and some digit"}
	#after_create :send_admin_mail
  after_create :assign_default_role
  after_create :create_dependencies
  after_create :capit
  def send_admin_mail
    UserMailer.welcome_email(self).deliver_now!
  end
  def is_company?
    has_role? :company
  end
  def is_admin?
    has_role? :admin
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
  def follows
    Follow.where(follower: self.id)
  end

  def assign_default_role
    if company
      self.add_role(:company) if self.roles.blank?
    else
      self.add_role(:user) if self.roles.blank?
    end
  end
end
