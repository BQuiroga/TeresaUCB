class Knowledge < ActiveRecord::Base
  belongs_to :knowledge_area
  belongs_to :resume
  def user
    resume=self.resume
    user=resume.user
  end
end
