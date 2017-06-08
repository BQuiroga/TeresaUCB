class Notification < ActiveRecord::Base
  belongs_to :user
  belongs_to :post
  validates :sender, presence: true
  before_create :no_self
  def user_sender
  	User.find(self.sender)
  end
  def no_self
  	user_id!=sender
  end
end
