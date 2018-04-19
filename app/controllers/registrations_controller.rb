class RegistrationsController < Devise::RegistrationsController
  protected
  def after_sign_up_path_for(resource)
   '/users/edit'
 end
 def delete
   @user=current_user
   current_user.picture.destroy
   if (@user.is_company?)
     @info=@user.company_information
     @user.resume.destroy
   else
     @info=@user.personal_information
   end

   @info.destroy
 end
  private

  def sign_up_params
    params.require(:user).permit(:name, :last_name, :email, :password, :password_confirmation,:company)
  end

  def account_update_params
    params.require(:user).permit(:name, :last_name, :email, :password, :password_confirmation, :current_password)
  end
end
