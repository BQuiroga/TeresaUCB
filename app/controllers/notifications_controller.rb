class NotificationsController < ApplicationController
	def index
		@notifications=current_user.notifications
	end
	def new
		@post=Post.find(params[:id])
	end
	def create
		@notification=Notification.new(notification_params)
		@notification.send_application_email
		@notification.save
		redirect_to '/users/profile'
	end
	def show
		@notification=Notification.find(params[:id])
		@notification.readed=true
		@notification.save
		@sender=@notification.user_sender
	end
	def read
		@notification=Notification.find(params[:id])
		@notification.readed=true
		@notification.save
		redirect_to '/mis_notificaciones'
	end
	def unread
		@notification=Notification.find(params[:id])
		@notification.readed=false
		@notification.save
		redirect_to '/mis_notificaciones'
	end
	def notification_params
		params.require(:notification).permit(:id,:title,:user_id,:description,:sender,:post_id,:readed)
	end
end
