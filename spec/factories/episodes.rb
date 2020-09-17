FactoryBot.define do
  factory :episode, class: Episode do
    association :season
    sequence(:title)          { |n| "Episode #{n}" }
    sequence(:plot)           { |n| "Episode #{n} from Season" }
    sequence(:episode_number) { |n| n }
  end
end