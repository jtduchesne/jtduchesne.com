FactoryBot.define do
  factory :post do
    title    { Faker::Lorem.words.join(" ") }
    preview  { Faker::Lorem.paragraph }
    
    content  { Faker::Lorem.paragraphs(number: 2).map{|p| "<div>#{p}</div>"}.join }
    
    published_on { nil }
    
    slug { title.parameterize }
    
    trait :translated do
      association(:translated, factory: :post)
    end
    
    trait :already_published do
      published_on { rand(1..52).weeks.ago }
    end
    trait :published do
      published_on { Date.today }
    end
    trait :to_be_published do
      published_on { rand(1..52).weeks.from_now }
    end
    
    trait :with_tag do
      after(:create) do |post|
        create(:tag, posts: [post])
      end
    end
    trait :with_tags do
      transient do
        tags_count { 2 }
      end
      after(:create) do |post, evaluator|
        create_list(:tag, evaluator.tags_count, posts: [post])
      end
    end
  end
end
