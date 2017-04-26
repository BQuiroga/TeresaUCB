class AddAreaToKnowledge < ActiveRecord::Migration
  def change
    add_column :knowledges, :area, :string
  end
end
