# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


puts 'Creating movies ...'

(1..20).each do |i|
  Movie.create(title: "Movie #{i}", plot: "Plot from Movie #{i}")
end

puts 'Creating seasons and episodes ...'

(1..10).each do |i|
  season = Season.create(title: "Season #{i}", plot: "Plot from Season #{i}", number: i)

  (1..5).each do |u|
    Episode.create(season: season,
    title: "Episode #{u} from #{i}",
    plot: "Plot from episode #{u}, Season #{i}",
    episode_number: u)
  end
end

puts 'Creating user ...'

user = User.create(email: 'user@email.com')

puts 'Creating user purchases'

(1..5).each do |i|
  movie = Movie.find(i)
  PurchaseOption.create(library: user.library, purchaseble_id: movie.id, purchaseble_type: movie.class, price: 6.99, video_quality: :HD)
end

(1..5).each do |i|
  season = Season.find(i)
  PurchaseOption.create(library: user.library, purchaseble_id: season.id, purchaseble_type: season.class, price: 6.99, video_quality: :HD)
end

