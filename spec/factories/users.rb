FactoryBot.define do
  factory :user do
    id '2'
    nickname 'JohnTitor'
    email 'hogehoge@example.com'
    password 'hogepiyoFuga@1984'
    password_confirmation 'hogepiyoFuga@1984'
    birthday '2018-07-11'
  end

  trait :admin do
    id '1'
    nickname 'Admin'
    email 'admin@example.com'
    password 'admin@Admin'
    password_confirmation 'admin@Admin'
    authority 1
  end

  trait :another do
    id '5'
    email 'another@example.com'
  end
end
