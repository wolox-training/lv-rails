class ApiController < ActionController::Base
  include DeviseTokenAuth::Concerns::SetUserByToken
  include Pundit
  protect_from_forgery with: :null_session

  before_action :locale_translate

  def locale_translate
    I18n.locale = current_user&.locale || I18n.default_locale
  end

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from Pundit::NotAuthorizedError, with: :unauthorized_action

  private

  def record_not_found
    render json: { error: 'Record not found' }, status: :not_found
  end

  def unauthorized_action
    render json: { error: 'Unauthorized action' }, status: :forbidden
  end
end
