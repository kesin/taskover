class HomeController < ApplicationController

  layout 'index', only: [:index]

  def index
  end

  private

  # show devise form in index page
  # refer: https://pupeno.com/2016/04/26/show-a-devise-log-in-or-sign-up-forms-in-another-page/
  def resource_name
    :user
  end
  helper_method :resource_name

  def resource
    @resource ||= User.new
  end
  helper_method :resource

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end
  helper_method :devise_mapping

  def resource_class
    User
  end
  helper_method :resource_class

end