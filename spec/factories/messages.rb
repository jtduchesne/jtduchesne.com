FactoryBot.define do
  factory :message do
    from    { Faker::Name.name }
    subject { Faker::Lorem.sentence }
    body    { Faker::Lorem.paragraph }
  end
end
