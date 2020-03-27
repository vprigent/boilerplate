class ApplicationController < ActionController::Base
  include ResourceExtensions
  include TraficExtensions
  include ResponseExtensions
  include DeviseExtensions
  include CustomsExtensions
  include ToggleExtensions
  include Pundit

  protect_from_forgery with: :exception

  rescue_from Pundit::NotAuthorizedError, with: :access_denied

  before_action :masquerade_user!

  def robots
    render text: ""
  end

  def is_admin?
    false
  end

  def controller_namespace
    []
  end

  def reject_unauthorized_user!
    unauthorized unless current_user.present? && current_user.admin?
  end
end
