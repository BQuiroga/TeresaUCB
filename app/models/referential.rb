class Referential < ActiveRecord::Base
  belongs_to :resume
  def user
    resume=self.resume
    user=resume.user
  end
end
