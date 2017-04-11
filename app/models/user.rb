class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :posts
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :password, format:{ with: /\A(?=.*[a-z])(?=.*[A-Z])./, message: "must contain at least one uppercase letter, one lowercase letter and some digit"}
	after_create :send_admin_mail
  def send_admin_mail
    UserMailer.welcome_email(self).deliver_later
  end
end
