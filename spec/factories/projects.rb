FactoryBot.define do
  factory :project do
    name        { Faker::Lorem.word }
    description { Faker::Lorem.paragraph(sentence_count: 2) }
    
    live_url   { Faker::Internet.url }
    github_url { "https://www.github.com/#{Faker::Internet.username}/#{name}/" }
  end
end
