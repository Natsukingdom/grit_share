require 'rails_helper'

# Test of User Model
RSpec.describe User, type: :model do
  describe 'register user' do
    before(:each) do
      @user = FactoryBot.build(:user)
    end

    context 'with invalid attributes' do
      it 'is invalid without nickname' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors[:nickname]).to include("can't be blank")
      end

      it 'is invalid with too long nickname' do
        @user.nickname = 'a' * 101
        @user.valid?
        expect(@user.errors[:nickname]).to include('is too long (maximum is 100 characters)')
      end

      it 'is invalid without email' do
        @user.email = ''
        @user.valid?
        expect(@user.errors[:email]).to include("can't be blank")
      end

      it 'is invalid with too long email' do
        @user.email = 'a' * 190 + '@exapmle.com'
        @user.valid?
        expect(@user.errors[:email]).to include('is too long (maximum is 191 characters)')
      end

      it 'is invalid with invalid format email' do
        invalid_addresses = %w[hogehoge hoge@example,com @example.com hoge@example hoge@examplecom]
        invalid_addresses.each do |invalid_address|
          @user.email = invalid_address
          @user.valid?
          expect(@user.errors[:email]).to include('is invalid')
        end
      end

      it 'is invalid with a duplicate email' do
        FactoryBot.create(:user)
        expect { FactoryBot.create(:user) }.to raise_error(ActiveRecord::RecordInvalid)
      end

      # @todo: 良い方法が見つかったら実装する
      # it 'is invalid with blank password'
    end

    context 'with valid attributes' do
      it 'is valid with nickname, email, password' do
        expect(@user).to be_valid
      end
    end
  end
end
