FactoryBot.define do
  factory :project do
    title { Faker::Internet.username }
    description { Faker::Internet.uuid }
    user_id { 1 }
  end
end
