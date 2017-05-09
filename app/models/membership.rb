class Membership < ActiveRecord::Base
  belongs_to :resume
  before_create :validate_date
  def validate_date
    date<Time.now
  end
  def user
    resume=self.resume
    user=resume.user
  end
end
