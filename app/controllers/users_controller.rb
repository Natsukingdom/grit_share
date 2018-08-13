class UsersController < ApplicationController
  before_action :set_user, only: [:show]

  # GET /users
  # GET /users.json
  def index
    if current_user.admin?
      @users = User.all
      @user = current_user
    else
      redirect_to User.find current_user.id
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    return if current_user&.admin?
    head 403 if current_user.id != @user.id
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:nickname, :email, :password,
                                 :password_confirmation, :birthday)
  end
end
