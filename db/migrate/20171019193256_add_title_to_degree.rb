class AddTitleToDegree < ActiveRecord::Migration
  def change
    add_reference :degrees, :title, index: true, foreign_key: true
  end
end
