class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!
  before_action :set_raven_context
  before_action :set_locale

  layout :layout_by_resource

  def layout_by_resource
    devise_controller? ? "devise" : "application"
  end

  def set_raven_context
    Raven.user_context(id: current_user.id) if !current_user.nil?
    Raven.extra_context(params: params.to_unsafe_h, url: request.url)
  end

  def set_locale
    requested_locale = params[:locale] || session[:locale] || I18n.default_locale
    locale = FastGettext.set_locale(requested_locale)
    session[:locale] = locale
    I18n.locale = locale
  end

  protected

  def configure_permitted_parameters
    added_attrs = [:username, :email, :password, :remember_me]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end
end
