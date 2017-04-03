class Post < ActiveRecord::Base
  default_scope -> {order(created_at: :desc)}
  has_many :pictures
end
