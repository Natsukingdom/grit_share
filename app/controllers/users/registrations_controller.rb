# determine to refine some methods of devise registration controller
class Users::RegistrationsController < ::Devise::RegistrationsController
  prepend_before_action :require_no_authentication, only: [:cancel]
  def after_sign_in_path_for(user)
    user_url(user)
  end

#  def sign_up(resource_name, resource)
#    if current_user&.admin?
#      redirect_to user_url(@user)
#      return
#    end
#    super(resource_name, resource)
#  end

  def create
    if current_user&.general?
      head 403
      return
    end
    super do
      if current_user&.admin? && resource.persisted?
        redirect_to user_url(@user)
        return
      end
    end
  end
end
