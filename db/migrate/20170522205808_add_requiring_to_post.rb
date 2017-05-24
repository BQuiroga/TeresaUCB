class AddRequiringToPost < ActiveRecord::Migration
  def change
    add_column :posts, :requiring, :boolean
  end
end
