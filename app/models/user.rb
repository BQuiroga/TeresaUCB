class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :posts
  has_one :personal_information
  has_one :resume
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :password, format:{ with: /\A(?=.*[a-z])(?=.*[A-Z])./, message: "must contain at least one uppercase letter, one lowercase letter and some digit"}
	#after_create :send_admin_mail
  after_create :create_dependencies
  def send_admin_mail
    UserMailer.welcome_email(self).deliver_now!
  end
  def create_dependencies
    Resume.create(:user_id => self.id)
    PersonalInformation.create(:user_id => self.id)
  end
end
