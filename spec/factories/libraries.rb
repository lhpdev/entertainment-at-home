FactoryBot.define do
  factory :library, class: Library do
    association :user
    created_at  { DateTime.current }
    updated_at  { DateTime.current }
  end
end