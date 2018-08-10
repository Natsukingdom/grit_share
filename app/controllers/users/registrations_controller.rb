# determine to refine some methods of devise registration controller
class Users::RegistrationsController < ::Devise::RegistrationsController
  prepend_before_action :require_no_authentication, only: [:cancel]
  def after_sign_in_path_for(user)
    user_url(user)
  end

  def new
    super do
      if current_user&.general?
        head 403
        return
      end
    end
  end

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
