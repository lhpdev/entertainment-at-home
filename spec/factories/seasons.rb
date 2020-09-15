FactoryBot.define do
  factory :season, class: Season do
    sequence(:title)  { |n| "Season #{n}" }
    sequence(:plot)   { |n| "Plot from season #{n}" }
    sequence(:number) { |n| n }
    created_at        { DateTime.current }
    updated_at        { DateTime.current }
  end
end