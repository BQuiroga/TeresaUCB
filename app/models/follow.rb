class Follow < ActiveRecord::Base
  before_create :no_self
  def no_self
    follower!=followed
  end
  def user
    resume=self.resume
    user=resume.user
  end
end
