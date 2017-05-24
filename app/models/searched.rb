class Searched < ActiveRecord::Base
  before_create :no_self
  before_create :no_repeat
  def no_self
    searched_by!=found
  end
  def no_repeat
    @exist=Searched.where(searched_by:searched_by,found:found)
    !@exist
  end
  def clean
    Searched.delete_all 
  end
  def user
    resume=self.resume
    user=resume.users
  end
end
