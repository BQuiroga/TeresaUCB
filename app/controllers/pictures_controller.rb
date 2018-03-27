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
   if @picture.save
    flash[:notice] = "Successfully added new photo!"
   else
    flash[:alert] = "Error adding new photo!"
   end
	 redirect_to '/users/profile'
  end
  private

  #Permitted parameters when creating a photo. This is used for security reasons.
  def picture_params
   params.require(:picture).permit(:title, :image,:user_id)
  end

 end
