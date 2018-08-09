require 'rails_helper'
require 'pry-byebug'

RSpec.describe UsersController, type: :request do

  before(:each) do
    create(:user, :admin)
    # id を指定して保存した場合、自動でシーケンスが進まないのでこちらの処理を追加している。
    ActiveRecord::Base.connection.execute("SELECT setval('users_id_seq', coalesce((SELECT MAX(id)+1 FROM users), 1), false)")
    create(:user)
    ActiveRecord::Base.connection.execute("SELECT setval('users_id_seq', coalesce((SELECT MAX(id)+1 FROM users), 1), false)")
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
        expect(response).to redirect_to user_url(User.last)
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
      it 'redirects to user page' do
        expect do
          sign_in admin
          post '/users', params: { user: attributes_for(:user, :another) }
        end.to change(User, :count).by(1)
        expect(response).to redirect_to user_url(User.last)
      end
    end

    context 'general user' do
      let(:user) { build(:user) }
      it 'returns 403 forbidden' do
        expect do
          sign_in user
          post '/users', params: { user: attributes_for(:user, :another) }
        end.to change(User, :count).by(0)
        expect(response.status).to eq 403
      end
    end
    context 'user not signed_in' do
      it 'returns 200' do
        expect do
          post '/users', params: { user: attributes_for(:user, :another) }
        end.to change(User, :count).by(1)
        expect(response).to redirect_to(user_url(User.last))
      end
    end
  end

  describe 'PATCH #update' do
    context 'by admin' do
      let(:user) { build(:user, :admin) }
      context 'with invalid params' do
        it 'does not update user' do
          sign_in user
        end
      end

      context 'with valid params' do
        it 'updates user'
        it 'redirects user page'
      end
    end

    context 'general user' do
      context 'to self account' do
        context 'with valid params' do
          it 'updates userself'
          it 'redirects userself page'
        end

        context 'with invalid params' do
          it 'does not update user'
        end
      end
    end

    context 'not signed in user' do
      it 'does not updates any user'
      it 'redirects sign_in page'
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested user'

    it 'redirects to the users list'
  end
end
