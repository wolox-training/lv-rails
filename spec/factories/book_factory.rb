FactoryBot.define do
  factory :book do
    genre { Faker::Book.genre }
    author { Faker::Book.author }
    title { Faker::Book.title }
    publisher { Faker::Book.publisher }
    image { Faker::Book.title }
    year { Faker::Date.between(10.days.ago, Date.today).year.to_s }
  end
end
