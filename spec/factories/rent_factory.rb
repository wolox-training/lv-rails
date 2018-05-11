FactoryBot.define do
  factory :rent do
    user { build(:user) }
    book { build(:book) }
    from { Faker::Date.between(Faker::Date.backward(10), Faker::Date.backward(2)) }
    to { Faker::Date.backward(2) }
  end
end
