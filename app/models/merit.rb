class Merit < ActiveRecord::Base
  belongs_to :resume
  before_create :validate_date
  def validate_date
    date<Time.now
  end
end
