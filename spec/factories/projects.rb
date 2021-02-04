FactoryBot.define do
  factory :project do
    name        { Faker::Lorem.word }
    description { {fr: description_fr, en: description_en} }
    
    transient do
      description_fr { Faker::Lorem.paragraph(sentence_count: 2) }
      description_en { Faker::Lorem.paragraph(sentence_count: 2) }
    end
    
    live_url   { Faker::Internet.url }
    github_url { "https://www.github.com/#{Faker::Internet.username}/#{name}/" }
  end
end
