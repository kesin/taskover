# Devise Registrations Controller
class RegistrationsController < Devise::RegistrationsController
  protect_from_forgery

  before_action :config_permitted_parameters

  def edit
    return redirect_to root_path, alert: '当前用户不允许修改账户信息！' if current_user.ident == 'demo'
    super
  end

  private

  def config_permitted_parameters
    devise_parameter_sanitizer.permit :sign_up, keys: User::ACCESSABLE_ATTRS
    devise_parameter_sanitizer.permit :account_update, keys: User::ACCESSABLE_ATTRS
    devise_parameter_sanitizer.permit :sign_in, keys: User::ACCESSABLE_ATTRS
  end

end