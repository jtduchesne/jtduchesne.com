FactoryBot.define do
  factory :project do
    name        { Faker::Lorem.words(number: 2).join(" ") }
    description { {fr: description_fr, en: description_en} }
    
    transient do
      description_fr { Faker::Lorem.paragraph(sentence_count: 2) }
      description_en { Faker::Lorem.paragraph(sentence_count: 2) }
    end
    
    live_url   { Faker::Internet.url }
    github_url { "https://www.github.com/#{Faker::Internet.username}/#{name}/" }
    
    slug { name.parameterize }
    
    trait :with_tag do
      after(:create) do |project|
        create(:tag, projects: [project])
      end
    end
    trait :with_tags do
      transient do
        tags_count { 2 }
      end
      after(:create) do |project, evaluator|
        create_list(:tag, evaluator.tags_count, projects: [project])
      end
    end
  end
end
