# determine to refine some methods of devise registration controller
class Users::RegistrationsController < ::Devise::RegistrationsController
  prepend_before_action :require_no_authentication, only: [:cancel]
  def after_sign_in_path_for(user)
    unless current_user.admin?
      return '/users/sign_in'
    end
    "/users/#{user.id}"
  end
end
