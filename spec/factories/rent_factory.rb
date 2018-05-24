FactoryBot.define do
  factory :rent do
    user { build(:user) }
    book { build(:book) }
    from { Faker::Date.between(5.days.ago, 3.days.ago) }
    to { Faker::Date.between(2.days.ago, 1.day.ago) }
  end
end
