class RegistrationsController < Devise::RegistrationsController
  def update
    @user= current_user
    if @user.update(account_update_params)
      # Sign in the user by passing validation in case their password changed
      bypass_sign_in(@user)
    end
    redirect_to '/users/edit'
  end
  protected
  def after_sign_up_path_for(resource)
   '/users/edit'
 end

 def update_password
   @user = current_user
    if @user.update(password_update_params)
      # Sign in the user by passing validation in case their password changed
      bypass_sign_in(@user)
    end
    redirect_to 'users/edit'
 end
 def edit

   @company_info=@user.company_information
   @company_information=current_user.company_information
   if (@user.is_company?)
     @t=@user.name
   end
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
  def password_update_params
    params.require(:user).permit(:password,:password_confirmation,:current_password)
  end
  # def sign_up_params
  #   params.require(:user).permit(:name, :last_name, :email, :password, :password_confirmation,:company)
  # end
  def account_update_params
    params.require(:user).permit(:name, :last_name, :email,:password)
  end
  def sign_up_params
    params.require(:user).permit(:company,:name,:last_name,:email,:password,:password_confirmation)
  end
end
