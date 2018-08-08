require 'rails_helper'

RSpec.describe PomosController, type: :request do
  let(:pomo) do
    build(:pomo)
  end

  before(:each) do
    create(:user)
    create(:user, :admin)
  end

  let(:valid_session) { {} }

  describe 'GET #index' do
    shared_examples_for 'all users' do
      it do
        sign_in user
        pomo.save
        get '/pomos'
        expect(response.status).to eq 200
      end
    end

    context 'admin_user' do
      let(:user) { build(:user, :admin) }
      it_behaves_like 'all users'
    end

    context 'general_user' do
      let(:user) { build(:user) }
      it_behaves_like 'all users'
    end
  end

  describe 'GET #show' do
    shared_examples_for 'owner and admin' do
      it 'returns success response' do
        sign_in user
        pomo.save
        get "/pomos/#{pomo.id}"
        expect(response.status).to eq 200
      end
    end
    context 'admin_user' do
      let(:user) { build(:user, :admin) }
      it_behaves_like 'owner and admin'
    end

    context 'general_user_owner' do
      let(:user) { build(:user) }
      it_behaves_like 'owner and admin'
    end

    context 'general_user_not_owner' do
      let(:user) { create(:user, :another) }
      it 'returns 403 forbidden' do
        sign_in user
        pomo.save
        get "/pomos/#{pomo.id}"
        expect(response.status).to eq 403
      end
    end
  end

  describe 'GET #new' do
    context 'signed in by any user' do
      it 'returns a success response' do
        sign_in build(:user)
        get '/pomos/new'
        expect(response.status).to eq 200
      end
    end

    context 'not signed in' do
      it 'returns 302 response' do
        get '/pomos/new'
        expect(response.status).to eq 302
      end
    end
  end

  describe 'GET #edit' do
    shared_examples_for 'owners' do
      it 'return 200' do
        sign_in user
        pomo.save
        get "/pomos/#{pomo.id}/edit"
        expect(response.status).to eq 200
      end
    end
    context 'admin_user' do
      let(:user) { build(:user, :admin) }
      it_behaves_like 'owners'
    end

    context 'general_user_owner' do
      let(:user) { build(:user) }
      it_behaves_like 'owners'
    end
    context 'general_user_not_owner' do
      let(:user) { create(:user, :another) }
      it 'returns a 403 forbidden' do
        sign_in user
        pomo.save
        get "/pomos/#{pomo.id}/edit"
        expect(response.status).to eq 403
      end
    end
  end

  describe 'POST #create' do
    let(:user) { build(:user) }
    context 'with valid params' do
      it 'creates a new Pomo' do
        sign_in user
        expect do
          post '/pomos', params: { pomo: attributes_for(:pomo) }
        end.to change(Pomo, :count).by(1)
        expect(response).to redirect_to(Pomo.last)
      end
    end

    context 'with invalid params' do
      it "returns a success response (i.e. to display the 'new' template)" do
        pomo.user_id = 2
        sign_in user
        expect do
          post '/pomos', params: { pomo: pomo.attributes }
        end.to change(Pomo, :count).by(0)
        expect(response.status).to eq 200
      end
    end
  end

  describe 'PUT #update' do
    let(:user) { build(:user) }
    context 'with valid params' do
      it 'updates the requested pomo' do
        sign_in user
        pomo.save
        put "/pomos/#{pomo.id}", params: { pomo: { comment: 'new attributes' } }
        expect(Pomo.find_by_id(pomo.to_param).comment).to eq('new attributes')
        expect(response).to redirect_to(pomo)
      end
    end

    context 'with invalid params' do
      it 'returns a success response' do
        pomo.save
        sign_in user
        put "/pomos/#{pomo.id}", params: { pomo: { passage_seconds: '-10' } }
        expect(response).to have_http_status(200)
        expect(Pomo.find(pomo.id).passage_seconds).not_to eq(-10)
      end
    end
  end

  describe 'DELETE #destroy' do
    shared_examples_for 'owner and admin' do
      it 'able to delete' do
        pomo.save
        expect do
          sign_in user
          delete "/pomos/#{pomo.id}"
        end.to change(Pomo, :count).by(-1)
        expect(response).to redirect_to(pomos_url)
      end
    end
    context 'owner' do
      let(:user) { build(:user) }
      it_behaves_like 'owner and admin'
    end

    context 'admin' do
      let(:user) { build(:user) }
      it_behaves_like 'owner and admin'
    end

    context 'not a owner' do
      let(:user) { create(:user, :another) }
      it 'disable to delete' do
        pomo.save
        expect do
          sign_in user
          delete "/pomos/#{pomo.id}"
        end.to change(Pomo, :count).by(0)
        expect(response.status).to eq 403
      end
    end
  end
end
