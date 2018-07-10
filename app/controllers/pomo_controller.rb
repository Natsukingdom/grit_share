class PomoController < ApplicationController
  # newするメソッド
  def new
    @pomo = Pomo.new
  end

  def list
    @pomos = Pomo.all
  end
end
