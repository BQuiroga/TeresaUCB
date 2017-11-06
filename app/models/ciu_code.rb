class CiuCode < ActiveRecord::Base
  validates :ciu, uniqueness: true
end
