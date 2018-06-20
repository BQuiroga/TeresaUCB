class UsersController < ApplicationController

	def show
	end
	def profile
		@picture=current_user.picture
		@user=current_user
		@belongs=@user.group_managers
		@groups=[]
		@belongs.each do |my_group|
			@group=my_group.group
			@groups=@groups+[@group]
		end
		@posts= current_user.posts
		@posts=@posts+current_user.follows_posts+current_user.searched_people_posts+current_user.my_friends_posts
		@posts=@posts.uniq
	end
	def search
		@busqueda_param=search_params[:name]
		@busqueda_param=@busqueda_param.split(' ')
		@users=current_user.search(@busqueda_param)
  	@users=@users.uniq
	end
	def bloquear
		if !current_user.is_administrator
			throwUnauthorized
			return
		else
			@user=User.find(params[:id])
			@user.lock_access!({send_instructions: false})
			redirect_to '/users'
		end
	end
	def desbloquear
		if !current_user.is_administrator
			throwUnauthorized
			return
		else
			@user=User.find(params[:id])
			@user.unlock_access!
			redirect_to '/users'
		end
	end
	def index
		if !(current_user.is_administrator)
			throwUnauthorized
			return
		else
			@users=User.all
		end
	end

	def reportes_general
		if !(current_user.is_director)
			throwUnauthorized
			return
		else
			@users=User.all
			@perso=Education.new
			@personal_by_gender=PersonalInformation.group(:gender).count
			@info_charts=Hash.new
			@used_genders=Hash.new
			@date_users=User.group_by_month(:created_at).count
			@university_users=Education.group(:school_name).count
			@catolica_users=Education.where(school_name:"Universidad Catolica San Pablo")
			@career_users=@catolica_users.group(:title).count
			@salaries=Experience.all.group(:salary_range).count
			@info_charts={"Hombres"=>@personal_by_gender[true],"Mujeres"=>@personal_by_gender[false],"Empresas"=>@personal_by_gender[nil]}
			@used_schools=@perso.chart_names
			@used_schools.each do |school|
				@used_genders[school]=@perso.genders(school)
			end
			@data=Array.new(@used_schools.size)
			i=0
			@used_genders.each do |gender|
				@data[i]={name:gender[0], data:[["Hombres",gender[1].count(true)],["Mujeres",gender[1].count(false)],["Empresas",gender[1].count(nil)]]}
				i+=1
			end
			@companies_by_code=CompanyInformation.group(:ciu_code_id).count
			@companies_names=Hash.new
			@companies_by_code.each do |c|
				if (c[0]!=nil)
					@companies_names[CiuCode.find(c[0]).description]=c[1]
				end
			end
			@years=Hash.new(0)
			@users.where(company:false).each do |u|
				if (u.years_to_first_job==-1)
					@years["Aun no ha egresado"]+=1
				else
					@years[u.years_to_first_job] +=1
				end
			end
			@experiences=Experience.all
			@jobs_time=Hash.new(0)
			@experiences.each do |e|
				if (e.time_in_job==-1)
					@jobs_time["Continua trabajando"]+=1
				else
					@jobs_time[e.time_in_job] +=1
				end
			end
		end
	end
	def destroy
    @user = current_user
    @user.destroy
    if @user.destroy
        redirect_to root_url, notice: "Usuario Eliminado."
    end
  end
	def new_report
		if !current_user.is_company?
			throwUnauthorized
			return
		else
		@city=report_params[:city]
		@university=report_params[:university]
		@gender=report_params[:gender]
		if (@city)
		end
	end
	def update_password
		@user = current_user
		 if @user.update(password_update_params)
			 # Sign in the user by passing validation in case their password changed
			 bypass_sign_in(@user)
		 end
		 redirect_to 'users/edit'
	end

	end
	def password_update_params
		params.require(:user).permit(:password,:password_confirmation,:current_password)
	end
	def search_params
  	params.require(:user).permit(:name,:last_name)
	end
	def report_params
		params.require(:user).permit(:city,:gender,:university)
	end
end
