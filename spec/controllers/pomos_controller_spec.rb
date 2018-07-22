require 'rails_helper'

RSpec.describe PomosController, type: :controller do
  let(:pomo) do
    FactoryBot.build(:pomo)
  end

  before(:each) { login_user }

  let(:valid_session) { {} }

  describe 'GET #index' do
    it 'returns a success response' do
      pomo.save
      get :index, params: {}, session: valid_session
      expect(response).to be_success
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      pomo.save
      get :show, params: { id: pomo.to_param }, session: valid_session
      expect(response).to be_success
    end
  end

  describe 'GET #new' do
    it 'returns a success response' do
      get :new, params: {}, session: valid_session
      expect(response).to be_success
    end
  end

  describe 'GET #edit' do
    it 'returns a success response' do
      pomo.save
      get :edit, params: { id: pomo.to_param }, session: valid_session
      expect(response).to be_success
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Pomo' do
        expect do
          post :create,
               params: { pomo: FactoryBot.attributes_for(:pomo) },
               session: valid_session
        end.to change(Pomo, :count).by(1)
      end

      it 'redirects to the created pomo' do
        post :create,
             params: { pomo: FactoryBot.attributes_for(:pomo) },
             session: valid_session
        expect(response).to redirect_to(Pomo.last)
      end
    end

    # @todo: あしたはここから調整
    context 'with invalid params' do
      it "returns a success response (i.e. to display the 'new' template)" do
        post :create, params: { pomo: invalid_attributes }, session: valid_session
        expect(response).to be_success
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) do
        skip('Add a hash of attributes valid for your model')
      end

      it 'updates the requested pomo' do
        pomo = Pomo.create! valid_attributes
        put :update, params: { id: pomo.to_param, pomo: new_attributes }, session: valid_session
        pomo.reload
        skip('Add assertions for updated state')
      end

      it 'redirects to the pomo' do
        pomo = Pomo.create! valid_attributes
        put :update, params: { id: pomo.to_param, pomo: valid_attributes }, session: valid_session
        expect(response).to redirect_to(pomo)
      end
    end

    context 'with invalid params' do
      it "returns a success response (i.e. to display the 'edit' template)" do
        pomo = Pomo.create! valid_attributes
        put :update, params: { id: pomo.to_param, pomo: invalid_attributes }, session: valid_session
        expect(response).to be_success
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested pomo' do
      pomo = Pomo.create! valid_attributes
      expect do
        delete :destroy, params: { id: pomo.to_param }, session: valid_session
      end.to change(Pomo, :count).by(-1)
    end

    it 'redirects to the pomos list' do
      pomo = Pomo.create! valid_attributes
      delete :destroy, params: { id: pomo.to_param }, session: valid_session
      expect(response).to redirect_to(pomos_url)
    end
  end
end
