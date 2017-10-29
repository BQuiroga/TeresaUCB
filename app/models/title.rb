class Title < ActiveRecord::Base
  has_many :degrees
  def title_name
    name
  end
end
