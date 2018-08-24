class PostsController < ApplicationController
  def create
  end
  def index
  end
  def new
  end
  def offer
    if !current_user.is_company?
			throwUnauthorized
			return
		else
    end
  end
  def show

  end
  def publicar
    if !current_user.is_company?
			throwUnauthorized
			return
		else
      new_post=Post.new
      new_post.new_post_body(search_params)
      @users=search_params[:results].split(' ')
      @users.each do |suggested_user_id|
        Searched.create(found:suggested_user_id,searched_by: current_user.id)
        suggested_user=User.find(suggested_user_id)
        new_post.send_notice_mail(suggested_user)
      end
      new_post.save
      redirect_to '/users/profile'
    end
  end
  def oferta_solo
    if !current_user.is_company?
			throwUnauthorized
			return
		else
      new_post=Post.new
      # new_post.body=personal_params[:comment]
      new_post.new_post_body_personal(personal_params)
      @user=User.find(personal_params[:id])
      Searched.create(found:@user.id,searched_by: current_user.id)
      new_post.send_notice_mail(@user)
      new_post.save
      redirect_to '/users/profile'
    end
  end

  def oferta
    if !current_user.is_company?
			throwUnauthorized
			return
		else
      @users=[]
      @count=0
      @post=Post.new
      if search_params[:titulo]
        @titulos=search_params[:titulo].capitalize.split(',')
      end
      if search_params[:post_grado]
        @postgrados=search_params[:post_grado].split(',')
      end
      if search_params[:cargo]
        @cargos=search_params[:cargo].split(',')
      end
      if search_params[:experiencia]
        @experiencias=search_params[:experiencia].split(',')
      end
      if search_params[:habilidades]
        @habilidades=search_params[:habilidades].split(',')
      end
      if search_params[:idiomas]
        @idiomas=search_params[:idiomas].split(',')
      end
      @educations=Education.where("title ~* ?", @titulos)+Education.where("title ~* ?",@postgrados)
      @experiences=Experience.where("job_title ~* ?", @cargos)+Experience.where("job_description ~* ? ",@experiencias)
      @knowledges=Knowledge.where("description ~* ?",@habilidades)
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
      @count=@post.search_params_count(@postgrados,@educations,@experiences,@knowledges,@languages)
      @languages.each do |language|
        @user=User.find(language.user.id)
        @users=@users+[@user]
      end
      @users=@users.select{ |e| @users.count(e)>=@count}.uniq
      @ids=[]
      @users.each do |user|
        @ids=@ids+[user.id]
      end
    end
  end

  def create
    Post.create(post_params)
    redirect_to '/users/profile'
  end
  def edit
    @post=Post.find(params[:id])
    if current_user.id!= @post.user.id
      throwUnauthorized
      return
    else
    end
  end
  def update
    @post=Post.find(post_params_for_edit[:id])
    @post.update(post_params)
    redirect_to '/users/profile', notice: 'Editado!'
  end
  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    if @post.destroy
        redirect_to '/users/profile', notice: "Se ha eliminado tu post!"
    end
  end
  private
  def personal_params
    params.require(:post).permit(:id,:comment,:contact,:name,:phone,:user_id)
  end
  def post_params
    params.require(:post).permit(:body,:user_id,:requiring)
  end
  def post_params_for_edit
    params.require(:post).permit(:body,:id,:requiring)
  end
  def picture_params
    params.require(:post).permit(:image)
  end
  def search_params
    params.require(:post).permit(:titulo,:ciudad,:post_grado,:cargo,:experiencia,:horas,:idiomas,:habilidades,:user_id,:phone,:contact,:results)
  end
end
