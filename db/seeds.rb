# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
User.destroy_all
Meal.destroy_all
Ingredient.destroy_all
Portion.destroy_all

puts "Creating users..."
user1 = User.new(email:"abc@example", password:"abcdef")
user2 = User.new(email:"123@example", password:"123456")
puts "#{User.count} users created"
