FactoryBot.define do
  factory :weather_forecast do
    zip_code { create(:zip_code) }
    current_temp { 70.0 }
    condition_icon { "https://cdn.weatherapi.com/weather/64x64/day/143.png" }
    high_temp { 75.0 }
    low_temp { 65.0 }
    date { Date.today }
  end
end
