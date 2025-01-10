FactoryBot.define do
  factory :zip_code do
    code { "12345" }
    city { "New York" }
    state { "NY" }
    latitude { 40.7128 }
    longitude { -74.0060 }
  end
end
