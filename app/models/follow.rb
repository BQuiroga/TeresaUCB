class Follow < ActiveRecord::Base
  before_create :no_self
  def no_self
    follower!=followed
  end
end
