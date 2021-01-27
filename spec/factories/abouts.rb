FactoryBot.define do
  factory :about do
    fr { "<div>Ceci est du texte en français</div>" }
    en { "<div>This is some text in english</div>" }
  end
end
