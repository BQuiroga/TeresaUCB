class PostsController < ApplicationController
  def create
    picture = post.pictures.create(picture_params)
  end
  def index
  end
  def new
  end
  def offer
  end
  def oferta
    new_post=Post.new
    new_body=new_post.job_offer(search_params[:titulo],search_params[:post_grado],search_params[:horas],search_params[:ciudad],search_params[:idiomas],search_params[:cargo],search_params[:experiencia],search_params[:habilidades])
    new_post.body=new_body
    new_post.user_id=search_params[:user_id]
    new_post.save
    redirect_to '/oferta/nueva'
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
  def search_params
    params.require(:post).permit(:titulo,:ciudad,:post_grado,:cargo,:experiencia,:horas,:idiomas,:habilidades,:user_id)
  end
end
