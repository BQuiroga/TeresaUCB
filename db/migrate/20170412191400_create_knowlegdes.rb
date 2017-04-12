class CreateKnowlegdes < ActiveRecord::Migration
  def change
    create_table :knowlegdes do |t|
      t.string :description
      t.references :knowledge_area, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
