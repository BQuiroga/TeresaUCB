class RenameTypeToPublicationTypeFromPublications < ActiveRecord::Migration
  def change
  	rename_column :publications, :type, :publicationType
  end
end
