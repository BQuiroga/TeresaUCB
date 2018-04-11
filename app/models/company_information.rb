class CompanyInformation < ActiveRecord::Base
  belongs_to :user
  belongs_to :ciu_code
  after_create :dependent
  def dependent
    self.ciu_code_id=1
  end
end
