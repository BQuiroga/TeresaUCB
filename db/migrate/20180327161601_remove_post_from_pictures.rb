class RemovePostFromPictures < ActiveRecord::Migration
  def change
    remove_reference :pictures, :post, index: true, foreign_key: true
  end
end
