class Group < ActiveRecord::Base
  has_many :group_managers
  def members
    self.group_managers.count
  end
end
