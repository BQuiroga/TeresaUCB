class RemoveKnowledgeAreaIdFromKnowledge < ActiveRecord::Migration
  def self.down
    remove_column :knowledges, :knowledge_area_id
  end
end
