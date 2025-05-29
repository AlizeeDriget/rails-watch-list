# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require "json"
require "open-uri"

omdbapiUrl = "http://www.omdbapi.com/?s=french&type=movie&apikey=adf1f2d7";

movie_serialized = URI.parse(omdbapiUrl).read
movies_hash = JSON.parse(movie_serialized)
movies = movies_hash["Search"]

puts "Cleaning database..."
Bookmark.destroy_all
Movie.destroy_all

movies.each do |movie|
  Movie.create!(title: movie["Title"], overview: "Neque porro quisquam est qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit#{movie["Title"]}", poster_url: movie["Poster"], rating: 6.9)
end
puts "Finished! Created #{Movie.count} movies."
