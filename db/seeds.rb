# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

ZipCode.destroy_all
WeatherForecast.destroy_all

zip_code1 = ZipCode.find_or_create_by!(code: "94103", latitude: 40.7128, longitude: -74.0060, city: "San Francisco", state: "CA")
zip_code2 = ZipCode.find_or_create_by!(code: "02144", latitude: 42.418, longitude: -71.107, city: "Medford", state: "MA")
zip_code3 = ZipCode.find_or_create_by!(code: "10001", latitude: 40.7128, longitude: -74.0060, city: "New York", state: "NY")
zip_code4 = ZipCode.find_or_create_by!(code: "33130", latitude: 25.7617, longitude: -80.1918, city: "Miami", state: "FL")

WeatherForecast.find_or_create_by!(zip_code: zip_code1, current_temp: 70.4, date: Date.today, high_temp: 75.0, low_temp: 68.0, condition_icon: "//cdn.weatherapi.com/weather/64x64/day/143.png", condition: "Sunny", feels_like: 72.0, wind_speed: 10.0)
WeatherForecast.find_or_create_by!(zip_code: zip_code2, current_temp: 87.2, date: Date.today, high_temp: 90.0, low_temp: 65.0, condition_icon: "//cdn.weatherapi.com/weather/64x64/day/113.png", condition: "Sunny", feels_like: 89.0, wind_speed: 10.0)
WeatherForecast.find_or_create_by!(zip_code: zip_code3, current_temp: 62.5, date: Date.today, high_temp: 65.0, low_temp: 60.0, condition_icon: "//cdn.weatherapi.com/weather/64x64/day/119.png", condition: "Sunny", feels_like: 64.0, wind_speed: 10.0)
WeatherForecast.find_or_create_by!(zip_code: zip_code4, current_temp: 73.0, date: Date.today, high_temp: 78.0, low_temp: 70.0, condition_icon: "//cdn.weatherapi.com/weather/64x64/day/176.png", condition: "Sunny", feels_like: 70.0, wind_speed: 10.0)
