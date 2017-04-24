class ChangeGivenToString < ActiveRecord::Migration
  def change
    change_column :courses, :given, :string
  end
end
