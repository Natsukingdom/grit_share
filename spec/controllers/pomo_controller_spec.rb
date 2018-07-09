require 'rails_helper'

RSpec.describe PomoController, type: :controller do
  describe "GET #list" do
    before { get :list, params: {}, session: {} }
    it "returns http status successful" do
      expect(response).to have_http_status(:success)
    end
    it "assigns all pomos to @pomos"
  end

  describe "GET #new" do
    before { get :new, params: {}, session: {} }
    it "returns http status successful" do
      expect(response).to  have_http_status(:success)
    end
    it 'assigns empty pomo to @pomo'
  end

  describe "GET #edit" do
    before { get :edit, params: {}, session: {} }
    it "returns http status successful" 
    it 'assings existing pomo to @pomo'
  end
end
