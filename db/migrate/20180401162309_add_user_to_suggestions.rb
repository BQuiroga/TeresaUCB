class AddUserToSuggestions < ActiveRecord::Migration
  def change
    add_reference :suggestions, :user, index: true, foreign_key: true
  end
end
