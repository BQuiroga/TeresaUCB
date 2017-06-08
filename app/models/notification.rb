class Notification < ActiveRecord::Base
  belongs_to :user
  belongs_to :post
  validates :sender, presence: true
  before_create :unreaded_all
  def user_sender
  	User.find(self.sender)
  end
  def unreaded_all
  	self.readed=false
  end
end
