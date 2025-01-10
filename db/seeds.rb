# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end


zip_code = ZipCode.find_or_create_by!(code: 94103)

WeatherForecast.create!(zip_code: zip_code, city: "San Francisco", state: "CA", current_temp: 70.0, date: Date.today, temp_max: 75.0, temp_low: 65.0, latitude: 40.7128, longitude: -74.0060)
