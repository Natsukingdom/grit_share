# determine to refine some methods of devise registration controller
class Users::RegistrationsController < ::Devise::RegistrationsController
  prepend_before_action :require_no_authentication, only: [:cancel]
  before_action :configure_account_update_params, only: [:update]
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

  private

  # ユーザ情報を更新する際にストロングパラメータでnicknameとbirthdayを許可するためにこのメソッドを作成した。
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:nickname, :birthday])
  end

  def after_update_path_for(resource)
    user_path(resource)
  end

  protected

  # passwordの指定よって処理を分岐する。
  def update_resource(resource, params)
    if params[:password].present? || params[:password_confirmation].present?
      resource.update_with_password(params)
    else
      %i[current_password password password_confirmation].each { |key| params.delete(key) }
      resource.update_without_password(params)
    end
  end

end
