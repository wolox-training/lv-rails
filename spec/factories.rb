FactoryBot.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { "#{first_name}.#{last_name}@wolox.com.ar".downcase }
    password 'password1234'
    password_confirmation 'password1234'
  end

  factory :book do
    genre { Faker::Book.genre }
    author { Faker::Book.author }
    title { Faker::Book.title }
    publisher { Faker::Book.publisher }
    image { Faker::Book.title }
    year { Faker::Date.year }
  end

end
