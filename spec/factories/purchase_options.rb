FactoryBot.define do
  factory :movie_purchase_option, class: PurchaseOption do
    association       :library
    association       :purchaseble, factory: :movie
    price             { 2.99 }
    video_quality     { 1 }
    created_at        { DateTime.current }
    updated_at        { DateTime.current }
  end

  factory :season_purchase_option, class: PurchaseOption do
    association      :library
    association      :purchaseble, factory: :season
    price            { 2.99 }
    video_quality    { 1 }
    created_at       { DateTime.current }
    updated_at       { DateTime.current }
  end
end