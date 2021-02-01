FactoryBot.define do
  factory :message do
    from    { Faker::Name.name }
    subject { Message.subjects.keys.sample }
    body    { Faker::Lorem.paragraph }
    
    trait :unread do
    end
    trait :read do
      after(:create) do |message|
        message.read!
      end
    end
  end
end
