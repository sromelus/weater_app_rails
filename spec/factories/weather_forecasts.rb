FactoryBot.define do
  factory :weather_forecast do
    zip_code { create(:zip_code) }
    current_temp { 70.0 }
    condition_icon { "sunny.png" }
    high_temp { 75.0 }
    low_temp { 65.0 }
    date { Date.today }
  end
end
