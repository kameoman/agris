# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  # ログイン後の遷移先
  def after_sign_in_path_for(resource)
    case resource
    when Admin
      admin_customers_profile_path
    when Customer
      customer_path(current_customer)
    end
  end

  # ログアウト後の遷移先
  def after_sign_out_path_for(resource_or_scope)
    if resource_or_scope == :admin
      root_path
    elsif resource_or_scope == :customer
      root_path
    end
    root_path
  end

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[customer_no name kana address phone_number])
  end
end
