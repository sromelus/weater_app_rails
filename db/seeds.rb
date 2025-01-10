# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end


zip_code = ZipCode.find_or_create_by!(code: 12345)

WeatherForecast.create!(zip_code: zip_code, city: "New York", state: "NY", current_temp: 70.0, date: Date.today)

