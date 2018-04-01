class PicturesController < ApplicationController
	def index
   @photos = Picture.order('created_at')
  end

  #New action for creating a new photo
  def new
   @picture = Picture.new
  end

  #Create action ensures that submitted photo gets created if it meets the requirements
  def create
   @picture = Picture.new(picture_params)
	 @picture.user_id=current_user.id
   if @picture.save
    flash[:notice] = "Successfully added new photo!"
		redirect_to '/users/profile'
   else
    flash[:alert] = "Error adding new photo!"
   end
  end
	def update
		@picture=current_user.picture
		if @picture.update(picture_params)
			redirect_to '/users/profile'
		end
	end
  private
  #Permitted parameters when creating a photo. This is used for security reasons.
  def picture_params
   params.require(:picture).permit(:title, :image,:user_id)
  end
	def picture_params_for_edit
	 params.require(:picture).permit(:title, :image,:user_id)
	end
 end
