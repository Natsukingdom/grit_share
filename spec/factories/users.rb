FactoryBot.define do
  factory :user do
    id '1'
    nickname 'JohnTitor'
    email 'hogehoge@example.com'
    password 'hogepiyoFuga@1984'
    password_confirmation 'hogepiyoFuga@1984'
    birthday '2018-07-11'
  end
end
