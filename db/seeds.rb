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
MotivationalQuote.destroy_all

puts "Creating users..."
user1 = User.create!(email: "abc@example", password: "abcdef", username: "ABC")
user2 = User.create!(email: "123@example", password: "123456")
puts "#{User.count} users created"

puts "Creating meals..."
meal1 = Meal.create!(name: "Breakfast", date: "2025-05-28", user: user1)
meal2 = Meal.create!(name: "Lunch", date: "2025-05-28", user: user1)
meal3 = Meal.create!(name: "Dinner", date: "2025-05-28", user: user1)
meal4 = Meal.create!(name: "Snack", date: "2025-05-28", user: user1)
meal5 = Meal.create!(name: "Snack", date: "2025-05-28", user: user1)
meal6 = Meal.create!(name: "Snack", date: "2025-05-28", user: user1)
puts "#{Meal.count} meals created"

puts "Creating ingredients..."
ingredient1 = Ingredient.create!(name: "oats", calories: 389)
ingredient2 = Ingredient.create!(name: "milk", calories: 59)
ingredient3 = Ingredient.create!(name: "salmon, cooked", calories: 182)
ingredient4 = Ingredient.create!(name: "lettuce", calories: 14)
ingredient5 = Ingredient.create!(name: "konjac noodles", calories: 10)
ingredient6 = Ingredient.create!(name: "tomatoes", calories: 18)
ingredient7 = Ingredient.create!(name: "ketchup", calories: 97)
puts "#{Ingredient.count} ingredients created"

puts "creating portions..."
portion1 = Portion.create!(quantity: 50, meal: meal1, ingredient: ingredient1)
portion2 = Portion.create!(quantity: 150, meal: meal1, ingredient: ingredient2)
portion3 = Portion.create!(quantity: 150, meal: meal2, ingredient: ingredient3)
portion4 = Portion.create!(quantity: 150, meal: meal2, ingredient: ingredient4)
portion5 = Portion.create!(quantity: 150, meal: meal2, ingredient: ingredient5)
puts "#{Portion.count} portions created"

puts "creating quotes..."
quote1 = MotivationalQuote.create!(content: "Balance your plate: protein, fiber, healthy fats")
quote2 = MotivationalQuote.create!(content: "Calories count — and so do you")
quote3 = MotivationalQuote.create!(content: "Track it to crack it!")
quote4 = MotivationalQuote.create!(content: "Healthy habits start with your plate")
quote5 = MotivationalQuote.create!(content: "Less sugar, more smiles")
quote6 = MotivationalQuote.create!(content: "Healthy food, happy mood")
quote7 = MotivationalQuote.create!(content: "Five veggs a day keeps illness away")

puts "#{MotivationalQuote.count} quotes created"
