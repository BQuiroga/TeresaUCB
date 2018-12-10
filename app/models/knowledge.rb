class Knowledge < ActiveRecord::Base
  belongs_to :knowledge_area
  belongs_to :resume
  def user
    resume=self.resume
    user=resume.user
  end
  def knowledge_has(list)
    r=Array.new
    list.each do |education|
      r=r+ Knowledge.where("description~*?",education)
    end
    r
  end
end
