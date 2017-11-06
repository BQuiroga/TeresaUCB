class CompanyInformationsController < ApplicationController
  def new
  end
  def edit
  end
  def create
  end
  def update
    @company=CompanyInformation.find(company_info_params_for_edit[:id])
    @company.update(company_info_params_for_edit)
    redirect_to '/users/edit'
  end
  # def company_info_params
  #   params.require(:pompany_information).permit(:address,:user_id,:phone,:contact_email,:description,:nit)
  # end
  def company_info_params_for_edit
    params.require(:company_information).permit(:id,:address,:phone,:contact_email,:nit,:description,:contact_name,:ciu_code_id)
  end
end
