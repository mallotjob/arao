class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_locale

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_in, keys: [:username])
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end
end
