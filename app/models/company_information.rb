class CompanyInformation < ActiveRecord::Base
  belongs_to :user
  belongs_to :ciu_code
end
