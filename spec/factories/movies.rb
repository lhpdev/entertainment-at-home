FactoryBot.define do
  factory :movie, class: Movie do
    sequence(:title) { |n| "Movie #{n}" }
    sequence(:plot)  { |n| "Plot from movie #{n}" }
    created_at       { DateTime.current }
    updated_at       { DateTime.current }
  end
end