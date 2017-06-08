class NotificationsController < ApplicationController
	def index
		@notifications=current_user.notifications
	end
	def create
		notification.create(notification_params)
	end
	def show
		@notification=Notification.find(params[:id])
		@sender=@notification.user_sender
	end
	def read
		@notification=Notification.find(params[:id])
		@notification.readed=true
		@notification.update
	end
	def notification_params
		params.require(:notification).permit(:id,:title,:user_id,:description,:sender,:post_id)
	end
end
