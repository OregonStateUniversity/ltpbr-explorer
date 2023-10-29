class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    added_attrs = [:affiliation, :username, :name, :email, :password, :password_confirmation, :remember_me]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end

  private

  def after_sign_in_path_for(resource)
    current_user
  end

  def require_admin
    unless current_user&.admin_role?
      redirect_to root_path
      flash[:alert] = 'Restricted action, must be an Admin'
    end
  end

  def require_owner_or_admin
    unless @project.authored_by?(current_user) || current_user.admin_role?
      redirect_to root_path
      flash[:alert] = 'Only the project author can manage the project and its affiliations.'
    end
  end

end
