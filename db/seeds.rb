# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

catalog = [
      {name: "classic white tee", brand: "Aerie", category: "country"}, #1
      {name: "denim jeans", brand: "Aerie", category: "country"},
      {name: "loose tee", brand: "Aerie", category: "summer"},
      {name: "gym shorts", brand: "Aerie", category: "summer"},
      {name: "warm sweater", brand: "Aerie", category: "winter"}, #5
      {name: "long fleece pants", brand: "Aerie", category: "winter"},
      {name: "blouse", brand: "Aerie", category: "spring"},
      {name: "mini skirt", brand: "Aerie", category: "spring"},
      {name: "loose sweater", brand: "Aerie", category: "fall"},
      {name: "maxi skirt", brand: "Aerie", category: "fall"},
]

catalog.each do |attrs|
  Clothing.create!(attrs)
end

puts "Seeded #{Clothing.count} clothing items."