class UsersController < ApplicationController
	layout :resolve_layout
	def resolve_layout
		if index
			"application"
		else
			"application"
		end
	end
	def profile
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
		@user=User.find(params[:id])
		@user.lock_access!({send_instructions: false})
		redirect_to '/users'
	end
	def desbloquear
		@user=User.find(params[:id])
		@user.unlock_access!
		redirect_to '/users'
	end
	def index
		if !current_user.is_administrator
			throwUnauthorized
			return
		else
			@users=User.all
		end
	end
	def reportes_general
		@users=User.all
		@perso=Education.new
		@total_persons=PersonalInformation.all
		@personal_by_gender=PersonalInformation.group(:gender).count
		@info_charts=Hash.new
		@used_genders=Hash.new
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
			@companies_names[CiuCode.find(c[0]).description]=c[1]
		end
	end
	def new_report
		@city=report_params[:city]
		@university=report_params[:university]
		@gender=report_params[:gender]
		if (@city)
		end
	end
	def search_params
  	params.require(:user).permit(:name,:last_name)
	end
	def report_params
		params.require(:user).permit(:city,:gender,:university)
	end
end
