class Suggestion < ActiveRecord::Base
  belongs_to :user
  def sugestion_user(current_user_id)
    self.user_id==current_user_id
  end
end
