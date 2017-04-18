class PersonalInformationsController < ApplicationController
	def new
	end
	def edit
	end
	def create
	end
	def update
		@personal=PersonalInformation.find(personal_info_params_for_edit[:id])
		@personal.update(personal_info_params_for_edit)
		redirect_to '/users/edit'
	end
	def personal_info_params
  		params.require(:personal_information).permit(:address,:user_id,:phone,:cellphone,:birthdate)
  	end
  	def personal_info_params_for_edit
  		params.require(:personal_information).permit(:id,:address,:phone,:cellphone,:birthdate)
  	end
end
