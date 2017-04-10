class PostsController < ApplicationController
  def create
    picture = post.pictures.create(picture_params)
  end
  def index
  end
  private
  def post_params
    params.require(:post).permit(:body)
  end

  def picture_params
    params.require(:post).permit(:image)
  end
end
