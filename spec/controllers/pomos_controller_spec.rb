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

    context 'with invalid params' do
      it "returns a success response (i.e. to display the 'new' template)" do
        pomo.user_id = 2
        expect do
          post :create,
               params: { pomo: pomo.attributes },
               session: valid_session
        end.to change(Pomo, :count).by(0)
        expect(response).to have_http_status(200)
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      it 'updates the requested pomo' do
        pomo.save
        put :update,
            params: { id: pomo.to_param, pomo: { comment: 'new attributes' } },
            session: valid_session
        expect(Pomo.find_by_id(pomo.to_param).comment).to eq('new attributes')
      end

      it 'redirects to the pomo' do
        pomo.save
        put :update, params: { id: pomo.to_param, pomo: { comment: 'checking redirects' } }, session: valid_session
        expect(response).to redirect_to(pomo)
      end
    end

    context 'with invalid params' do
      it "returns a success response (i.e. to display the 'edit' template)" do
        pomo.save
        put :update, params: { id: pomo.to_param, pomo: { passage_seconds: '-10' } }, session: valid_session
        expect(response).to have_http_status(200)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested pomo' do
      pomo.save
      expect do
        delete :destroy, params: { id: pomo.to_param }, session: valid_session
      end.to change(Pomo, :count).by(-1)
    end

    it 'redirects to the pomos list' do
      pomo.save
      delete :destroy, params: { id: pomo.to_param }, session: valid_session
      expect(response).to redirect_to(pomos_url)
    end
  end
end
