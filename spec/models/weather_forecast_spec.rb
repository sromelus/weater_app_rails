require 'rails_helper'

RSpec.describe WeatherForecast, type: :model do
  let!(:zip_code) { create(:zip_code, code: 12345) }
  let!(:weather_forecast) { create(:weather_forecast, zip_code: zip_code, city: "New York", state: "NY", current_temp: 70.0, date: Date.today) }

  describe "validations" do
    it { should belong_to(:zip_code) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:state) }
    it { should validate_presence_of(:current_temp) }
    it { should validate_presence_of(:date) }
  end
end
