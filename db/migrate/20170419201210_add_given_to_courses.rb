class AddGivenToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :given, :boolean
  end
end
