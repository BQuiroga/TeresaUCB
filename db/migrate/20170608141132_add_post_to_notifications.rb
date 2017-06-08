class AddPostToNotifications < ActiveRecord::Migration
  def change
    add_reference :notifications, :post, index: true, foreign_key: true
  end
end
