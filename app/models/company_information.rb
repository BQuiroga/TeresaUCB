class CompanyInformation < ActiveRecord::Base
  belongs_to :user
  has_one :ciu_code
end
