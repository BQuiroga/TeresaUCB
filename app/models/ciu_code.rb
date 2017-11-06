class CiuCode < ActiveRecord::Base
  validates :ciu, uniqueness: true
  has_many :company_informations
end
