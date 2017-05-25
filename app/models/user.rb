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
  def phone
    self.company_information.phone
  end
  def contact_name
    self.company_information.contact_name
  end
  def suggested_publication(post)
    post
  end
  def assign_default_role
    if company
      self.add_role(:company) if self.roles.blank?
    else
      self.add_role(:user) if self.roles.blank?
    end
  end
end
