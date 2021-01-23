FactoryBot.define do
  factory :user do
    transient do
      first_name { Faker::Name.first_name }
      last_name  { Faker::Name.last_name }
    end
    
    sequence :email do |n|
      Faker::Internet.email(name: "#{first_name} #{last_name} #{n}", separators: ".")
    end
    
    trait :unverified do
    end
    trait :verified do
      after(:create) do |user|
        user.verify!(user.token)
      end
    end
    
    trait :without_otp do
    end
    trait :with_otp do
      transient do
        model { create(:user).tap{ |u| u.generate_onetime_password } }
      end
      
      after(:create) do |user, evaluator|
        user.update_columns otp_digest: evaluator.model.otp_digest
        user.otp = evaluator.model.otp
      end
    end
    
    trait :administrator do
      after(:create) do |user|
        user.send :make_admin!
      end
    end
  end
end
