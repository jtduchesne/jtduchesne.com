FactoryBot.define do
  factory :tag do
    name { Faker::Lorem.word }
    
    trait :with_projects do
      transient do
        projects_count { 1 }
      end
      after(:create) do |tag, evaluator|
        create_list(:project, evaluator.projects_count, tags: [tag])
      end
    end
  end
end
