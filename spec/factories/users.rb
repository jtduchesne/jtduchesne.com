FactoryBot.define do
  factory :user do
    transient do
      first_name { Faker::Name.first_name }
      last_name  { Faker::Name.last_name }
    end
    
    sequence :email do |n|
      Faker::Internet.email(name: "#{first_name} #{last_name} #{n}", separators: ".")
    end
    
    trait :administrator do
      after(:create) do |user|
        user.send :make_admin!
      end
    end
  end
end
