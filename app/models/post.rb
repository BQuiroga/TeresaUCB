class Post < ActiveRecord::Base
  default_scope -> {order(created_at: :desc)}
  has_many :pictures
  belongs_to :user
  def job_offer
    ""
  end
end
