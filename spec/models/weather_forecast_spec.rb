require 'rails_helper'

RSpec.describe WeatherForecast, type: :model do
  describe "validations" do
    subject { build(:weather_forecast) }

    it { should belong_to(:zip_code) }
    it { should validate_presence_of(:date) }
    it { should validate_presence_of(:current_temp) }
  end
end
