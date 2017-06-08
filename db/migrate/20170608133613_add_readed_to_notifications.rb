class AddReadedToNotifications < ActiveRecord::Migration
  def change
    add_column :notifications, :readed, :boolean
  end
end
