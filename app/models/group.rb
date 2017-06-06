class Group < ActiveRecord::Base
  has_many :group_managers
  belongs_to :user
  def members
    self.group_managers.count
  end
  def my_members
    users=[]
    self.group_managers.each do |union|
      users=users+[union.user]
    end
    users
  end
end
