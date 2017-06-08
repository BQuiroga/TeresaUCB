class ChangeSendToSender < ActiveRecord::Migration
  def change
  	rename_column :notifications, :send, :sender
  end
end
