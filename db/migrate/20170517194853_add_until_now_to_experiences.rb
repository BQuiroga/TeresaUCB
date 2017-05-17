class AddUntilNowToExperiences < ActiveRecord::Migration
  def change
    add_column :experiences, :until_now, :boolean
  end
end
