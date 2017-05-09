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
  def results
  end
  def oferta
    new_post=Post.new
    new_body=new_post.job_offer(search_params[:titulo],
                                search_params[:post_grado],
                                search_params[:horas],
                                search_params[:ciudad],
                                search_params[:idiomas],
                                search_params[:cargo],
                                search_params[:experiencia],
                                search_params[:habilidades])
    new_post.body=new_body
    new_post.user_id=search_params[:user_id]
    new_post.save
    @users=[]
    @titulos=search_params[:titulo].split(',')
    @postgrados=search_params[:post_grado].split(',')
    @cargos=search_params[:cargo].split(',')
    @experiencias=search_params[:experiencia].split(',')
    @habilidades=search_params[:habilidades].split(',')
    @idiomas=search_params[:idiomas].split(',')

    @educations=Education.where(title: [@titulos,@postgrados])
    @experiences=Experience.where(job_title: @cargos,job_description: @experiencias)
    @knowledges=Knowledge.where(description: @habilidades)
    @languages=Language.where(name:@idiomas)
    @educations.each do |education|
      @user=User.find(education.user.id)
      @users=@users+[@user]
    end
    @experiences.each do |experience|
      @user=User.find(experience.user.id)
      @users=@users+[@user]
    end
    @knowledges.each do |knowledge|
      @user=User.find(knowledge.user.id)
      @users=@users+[@user]
    end
    @languages.each do |language|
      @user=User.find(language.user.id)
      @users=@users+[@user]
    end
  end
  def create
    Post.create(post_params)
    redirect_to '/users/profile'
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
