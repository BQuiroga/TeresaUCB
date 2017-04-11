class PostsController < ApplicationController
  def create
    picture = post.pictures.create(picture_params)
  end
  def index
  end
  def new
  end
  def create
    Post.create(post_params)
    redirect_to root_path
  end
  private
  def post_params
    params.require(:post).permit(:body,:user_id)
  end
  def picture_params
    params.require(:post).permit(:image)
  end
end
