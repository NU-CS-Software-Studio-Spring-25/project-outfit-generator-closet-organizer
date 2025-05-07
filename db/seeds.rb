# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

Clothing.destroy_all

catalog = [
  # Country
  { name: "classic white tee", brand: "test", category: "country", article: "top" },
  { name: "denim jeans", brand: "a brand", category: "country", article: "bottom" },

  # Summer
  { name: "loose tee", brand: "famous", category: "summer", article: "top" },
  { name: "gym shorts", brand: "woad", category: "summer", article: "bottom" },
  { name: "tank top", brand: "oceanwear", category: "summer", article: "top" },
  { name: "linen pants", brand: "sunset", category: "summer", article: "bottom" },
  { name: "cropped halter", brand: "beach vibe", category: "summer", article: "top" },
  { name: "denim cutoffs", brand: "cool days", category: "summer", article: "bottom" },

  # Winter
  { name: "warm sweater", brand: "tea", category: "winter", article: "top" },
  { name: "long fleece pants", brand: "word", category: "winter", article: "bottom" },
  { name: "thermal shirt", brand: "snowbase", category: "winter", article: "top" },
  { name: "wool leggings", brand: "cozycore", category: "winter", article: "bottom" },
  { name: "hooded sweatshirt", brand: "nord", category: "winter", article: "top" },
  { name: "quilted joggers", brand: "icebound", category: "winter", article: "bottom" },

  # Spring
  { name: "blouse", brand: "bitfd", category: "spring", article: "top" },
  { name: "mini skirt", brand: "place", category: "spring", article: "bottom" },
  { name: "pastel cardigan", brand: "bloomline", category: "spring", article: "top" },
  { name: "pleated skirt", brand: "softstep", category: "spring", article: "bottom" },
  { name: "lace tank", brand: "florals inc", category: "spring", article: "top" },
  { name: "capri pants", brand: "petals", category: "spring", article: "bottom" },

  # Fall
  { name: "loose sweater", brand: "holder", category: "fall", article: "top" },
  { name: "maxi skirt", brand: "words", category: "fall", article: "bottom" },
  { name: "flannel shirt", brand: "leaves & co", category: "fall", article: "top" },
  { name: "corduroy pants", brand: "earthtone", category: "fall", article: "bottom" },
  { name: "layered tunic", brand: "acorn", category: "fall", article: "top" },
  { name: "wool blend trousers", brand: "mosswear", category: "fall", article: "bottom" }
]


catalog.each do |attrs|
  Clothing.find_or_create_by!(attrs)
end

puts "Seeded #{Clothing.count} clothing items."