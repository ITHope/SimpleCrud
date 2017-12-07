class ApplicationController < ActionController::Base
  before_action :authenticate_user!, :set_locale

  protect_from_forgery with: :exception

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
    current_user.set_lang(params[:locale]) if params[:locale] != nil
  end

end
