class PomosController < ApplicationController
  before_action :set_pomo, only: %i[show edit update destroy]
  before_action :set_user

  def index
    @user = User.find(request.url.split('/')[-2])
    @pomos = Pomo.where(user_id: @user.id)
    @pomos ||= []
  end

  def show
    return if @user.admin?
    if @pomo.user_id != @user.id
      @pomo = nil
      head 403
    end
  end

  def new
    @pomo = Pomo.new
  end

  def edit
    return if current_user.admin?
    if current_user.id != @pomo.user_id
      @pomo = nil
      head 403
    end
  end

  def create
    @pomo = Pomo.new(pomo_params)

    respond_to do |format|
      if @pomo.save
        format.html { redirect_to user_pomo_url(current_user, @pomo), notice: 'Pomo was successfully created.' }
        format.json { render :show, status: :created, location: @pomo }
      else
        format.html { render :new }
        format.json { render json: @pomo.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @pomo.update(pomo_params)
        format.html { redirect_to user_pomo_url(current_user, @pomo), notice: 'Pomo was successfully updated.' }
        format.json { render :show, status: :ok, location: @pomo }
      else
        format.html { render :edit }
        format.json { render json: @pomo.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    if current_user.id != @pomo.user_id
      head 403
      return
    end
    @pomo.destroy
    respond_to do |format|
      format.html { redirect_to user_pomos_url(current_user), notice: 'Pomo was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_pomo
    @pomo = Pomo.find(params[:id])
  end

  def pomo_params
    params.require(:pomo).permit(:user_id, :start_time, :stop_time, :end_time, :comment, :passage_seconds)
  end

  def set_user
    @user = current_user
  end
end
