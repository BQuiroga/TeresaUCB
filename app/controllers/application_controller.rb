class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_filter :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery with: :exception
  before_action :authenticate_user!, :except => [:inicio]

  def search
    @users=User.where(name: params[:name], last_name: params[:last_name])
  end
  def throwUnauthorized
    raise ActionController::RoutingError.new('Not Found')
  end
  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end
  protected

    def configure_permitted_parameters
        # Fields for sign up
        devise_parameter_sanitizer.permit(:sign_up, keys: [:name,:last_name, :email, :password])
        # Fields for editing an existing account
        devise_parameter_sanitizer.permit(:account_update, keys: [:name,:last_name, :email, :password, :password_confirmation, :current_password])
    end
end
