require 'rails_helper'
require 'pry-byebug'

RSpec.describe UsersController, type: :request do

  before(:each) do
    create(:user, :admin)
    create(:user)
    create(:pomo)
  end

  describe 'GET #index' do
    context 'signed_in by admin' do
      let(:user) { build(:user, :admin) }
      it 'returns a success response' do
        sign_in user
        get '/users'
        expect(response.status).to eq 200
      end
    end

    context 'signed_in by users but admin' do
      let(:user) { build(:user) }
      it 'returns 403' do
        sign_in user
        get '/users'
        expect(response).to redirect_to "/users/#{user.id}"
      end
    end
  end

  describe 'GET #show' do
    context 'show userself' do
      let(:user) { build(:user) }
      it 'returns a success response' do
        sign_in user
        get "/users/#{user.id}"
        expect(response.status).to eq 200
      end
    end

    context 'show anyuser by admin' do
      let(:admin) { build(:user, :admin) }
      it 'returns 200' do
        [build(:user), admin].each do |target_user|
          sign_in admin
          get "/users/#{target_user.id}"
          expect(response.status).to eq 200
        end
      end
    end

    context 'show not userself' do
      let(:user) { create(:user, :another) }
      it 'returns 403' do
        [build(:user), build(:user, :admin)].each do |not_self_user|
          sign_in user
          get "/users/#{not_self_user.id}"
          expect(response.status).to eq 403
        end
      end
    end
  end

  describe 'GET #new' do
    context 'admin' do
      let(:user) { build(:user, :admin) }
      it 'returns a success response' do
        sign_in user
        get '/users/new', params: { user: build(:user, :another).to_param }
        expect(response.status).to eq 200
      end
    end

    context 'user but admin' do
      let(:user) { build(:user) }
      it 'returns 403' do
        sign_in user
        get '/users/new', params: { user: build(:user, :another).to_param }
        expect(response.status).to eq 403
      end
    end

    context 'not signed_in' do
      it 'returns 200' do
        get '/users/new', params: { user: build(:user, :another).to_param }
        expect(response.status).to eq 200
      end
    end
  end

  describe 'GET #edit' do
    shared_examples_for 'edit by auth user' do
      it 'returns 200' do
        sign_in user
        get "/users/#{user.id}/edit"
      end
    end
    context 'admin' do
      let(:user) { build(:user, :admin) }
      it_behaves_like 'edit by auth user'
    end

    context 'general' do
      let(:user) { build(:user) }
      it_behaves_like 'edit by auth user'
    end

    context 'general user not self' do
      let(:user) { build(:user) }
      let(:another_user) { create(:user, :another) }
      it 'returns 403' do
        sign_in user
        get "/users/#{another_user.id}/edit"
        expect(response.status).to eq 403
      end
    end

    context 'not signed_in' do
      let(:user) { build(:user) }
      it 'returns 302' do
        get "/users/#{user.id}/edit"
        expect(response.status).to eq 302
      end
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new User' do
        expect do
          post '/users', params: { user: attributes_for(:user, :another) }
        end.to change(User, :count).by(1)
        expect(response).to redirect_to('/users/sign_in')
      end
    end

    context 'with invalid params' do
      it "returns a success response (i.e. to display the 'new' template)" do
        invalid_attributes = attributes_for(:user, :another)
        invalid_attributes[:email] = 'hoge'
        post '/users', params: { user: invalid_attributes }
        expect(response).to be_success
      end
    end

    context 'by admin' do
      let(:admin) { build(:user, :admin) }
      it 'returns 200' do
        expect do
          sign_in admin
          post '/users', params: { user: attributes_for(:user, :another) }
        end.to change(User, :count).by(1)
        expect(response).to redirect_to("/users/#{build(:user, :another).id}")
      end
    end

    context 'general user' do

    end
    context 'user not signed_in' do
      it 'returns 200'
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) do
        skip('Add a hash of attributes valid for your model')
      end

      it 'updates the requested user' do
        user = User.create! valid_attributes
        put :update, params: { id: user.to_param, user: new_attributes }, session: valid_session
        user.reload
        skip('Add assertions for updated state')
      end

      it 'redirects to the user' do
        user = User.create! valid_attributes
        put :update, params: { id: user.to_param, user: valid_attributes }, session: valid_session
        expect(response).to redirect_to(user)
      end
    end

    context 'with invalid params' do
      it "returns a success response (i.e. to display the 'edit' template)" do
        user = User.create! valid_attributes
        put :update, params: { id: user.to_param, user: invalid_attributes }, session: valid_session
        expect(response).to be_success
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested user' do
      user = User.create! valid_attributes
      expect do
        delete :destroy, params: { id: user.to_param }, session: valid_session
      end.to change(User, :count).by(-1)
    end

    it 'redirects to the users list' do
      user = User.create! valid_attributes
      delete :destroy, params: { id: user.to_param }, session: valid_session
      expect(response).to redirect_to(users_url)
    end
  end
end
