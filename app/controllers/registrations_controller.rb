class RegistrationsController < Devise::RegistrationsController
  protected
  def after_sign_up_path_for(resource)
   '/users/edit' 
 end

  private

  def sign_up_params
    params.require(:user).permit(:name, :last_name, :email, :password, :password_confirmation,:company)
  end

  def account_update_params
    params.require(:user).permit(:name, :last_name, :email, :password, :password_confirmation, :current_password)
  end
end
