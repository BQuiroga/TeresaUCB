class Knowledge < ActiveRecord::Base
  belongs_to :knowledge_area
  belongs_to :resume
end
