FactoryBot.define do
  factory :user, class: User do
    sequence(:email) { |n| "user#{n}@email.com" }
    created_at       { DateTime.current }
    updated_at       { DateTime.current }
  end
end