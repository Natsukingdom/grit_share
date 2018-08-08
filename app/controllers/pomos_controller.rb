class PomosController < ApplicationController
  before_action :set_pomo, only: %i[show edit update destroy]

  # GET /pomos
  # GET /pomos.json
  def index
    @pomos = current_user.admin? ? Pomo.all : Pomo.where(user_id: current_user.id)
    @pomos ||= []
  end

  # GET /pomos/1
  # GET /pomos/1.json
  def show
    return if current_user.admin?
    if @pomo.user_id != current_user.id
      @pomo = nil
      head 403
    end
  end

  # GET /pomos/new
  def new
    @pomo = Pomo.new
  end

  # GET /pomos/1/edit
  def edit
    return if current_user.admin?
    if current_user.id != @pomo.user_id
      @pomo = nil
      head 403
    end
  end

  # POST /pomos
  # POST /pomos.json
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

  # PATCH/PUT /pomos/1
  # PATCH/PUT /pomos/1.json
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

  # DELETE /pomos/1
  # DELETE /pomos/1.json
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

  # Use callbacks to share common setup or constraints between actions.
  def set_pomo
    @pomo = Pomo.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def pomo_params
    params.require(:pomo).permit(:user_id, :start_time, :stop_time, :end_time, :comment, :passage_seconds)
  end
end
