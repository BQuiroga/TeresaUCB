class Education < ActiveRecord::Base
  belongs_to :resume
  before_create :validate_date
	def validate_date
		start_date<end_date && start_date<Time.now
	end
  def user
    resume=self.resume
    user=resume.user
  end
end
