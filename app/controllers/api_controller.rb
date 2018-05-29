class ApiController < ActionController::Base
  include DeviseTokenAuth::Concerns::SetUserByToken
  include Pundit
  protect_from_forgery with: :null_session

  before_action :locale_translate

  def locale_translate
    I18n.locale = current_user&.locale || I18n.default_locale
  end
end
