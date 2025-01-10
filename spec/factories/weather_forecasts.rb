FactoryBot.define do
  factory :weather_forecast do
    zip_code { nil }
    city { "MyString" }
    state { "MyString" }
    current_temp { "9.99" }
    temp_max { "9.99" }
    temp_low { "9.99" }
    date { "2025-01-09 18:41:03" }
    latitude { "9.99" }
    longitude { "9.99" }
  end
end
