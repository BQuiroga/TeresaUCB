class CreateCiuCodes < ActiveRecord::Migration
  def change
    create_table :ciu_codes do |t|
      t.string :description

      t.timestamps null: false
    end
  end
end
