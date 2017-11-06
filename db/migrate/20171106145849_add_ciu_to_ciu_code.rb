class AddCiuToCiuCode < ActiveRecord::Migration
  def change
    add_column :ciu_codes, :ciu, :string
  end
end
