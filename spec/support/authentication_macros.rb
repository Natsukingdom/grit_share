module AuthenticationMacros
  def login_general_user
    sign_in FactoryBot.create(:user)
  end

  def login_admin_user
    sign_in FactoryBot.create(:user)
  end
end
