class Group < ActiveRecord::Base
  has_many :group_managers
  belongs_to :user
  def members
    self.group_managers.count
  end
end
