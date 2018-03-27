class AddImagePathToPictures < ActiveRecord::Migration
  def change
    add_column :pictures, :image_path, :string
  end
end
