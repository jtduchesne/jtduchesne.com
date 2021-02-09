FactoryBot.define do
  factory :post do
    title    { Faker::Lorem.words.join(" ") }
    preview  { Faker::Lorem.paragraph }
    
    published_on { nil }
    
    trait :already_published do
      published_on { rand(1..52).weeks.ago }
    end
    trait :published do
      published_on { Date.today }
    end
    trait :to_be_published do
      published_on { rand(1..52).weeks.from_now }
    end
  end
end
