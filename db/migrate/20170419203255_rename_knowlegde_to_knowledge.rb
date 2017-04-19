class RenameKnowlegdeToKnowledge < ActiveRecord::Migration
  def change
  	rename_table :knowlegdes, :knowledges
  end
end
