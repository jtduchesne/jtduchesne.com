FactoryBot.define do
  factory :about do
    fr { "<div>Ceci est du texte en français</div>" }
    en { "<div>This is some text in english</div>" }
    
    trait :draft do
      published_on { nil }
    end
    trait :published do
      published { true }
    end
  end
end
