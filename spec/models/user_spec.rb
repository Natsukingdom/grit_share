require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#create test data' do
    it 'create test data' do
      test_user = FactoryBot.create(:user)
      test_user.email
      p test_user
    end
  end
end
