class Searched < ActiveRecord::Base
  before_create :no_self
  validates_uniqueness_of :searched_by,:scope => :found
  def no_self
    searched_by!=found
  end
  def no_repeat
    buscador=self.searched_by
    buscado=self.found
    @exist=Searched.where(searched_by:buscador,found:buscado)
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
