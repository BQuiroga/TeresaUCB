class AddGroupToCiuCode < ActiveRecord::Migration
  def change
    add_column :ciu_codes, :group, :string
  end
end
