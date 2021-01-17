FactoryBot.define do
  factory :role do
    sequence(:name) { |n| "Role #{n}" }
    
    association(:user)
  end
end
