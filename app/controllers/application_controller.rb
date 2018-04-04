class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :store_user_location!, if: :storable_location?
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_locale
  before_action :set_paper_trail_whodunnit

  def ensure_signup_complete
    # Ensure we don't go into an infinite loop
    return if action_name == 'finish_signup'

    # Redirect to the 'finish_signup' page if the user
    # email hasn't been verified yet
    if current_user && !current_user.email_verified?
      redirect_to finish_signup_path(current_user)
    end
  end

  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.json { head :forbidden, content_type: 'text/html' }
      format.html { redirect_to main_app.root_url, notice: exception.message }
      format.js   { head :forbidden, content_type: 'text/html' }
    end
  end
  protected

  def set_locale
    I18n.locale = :es
  end
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :avatar, :crop_x, :crop_y, :crop_x2, :crop_y2, :crop_w, :crop_h, :crop_vy])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :avatar, :crop_x, :crop_y, :crop_x2, :crop_y2, :crop_w, :crop_h, :crop_vy])
  end
  def storable_location?
    request.get? && is_navigational_format? && !devise_controller? && !request.xhr?
  end
  def store_user_location!
    store_location_for(:user, request.fullpath)
  end
end
