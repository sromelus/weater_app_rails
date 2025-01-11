require "rails_helper"

RSpec.describe WeatherLookupService do
  let(:address) { Address.new("123 Main St, Boston, MA 02108") }
  let(:location) do
    double(
      "Location",
      postal_code: "02108",
      latitude: 42.3601,
      longitude: -71.0589
    )
  end
  let(:weather_client_service) { instance_double(WeatherClientService) }
  let(:forecast_data) { { temperature: 72, conditions: "sunny", condition_icon: "sunny.png" } }
  let(:zip_code) { create(:zip_code, code: "02108") }
  let(:weather_forecast) { create(:weather_forecast, zip_code: zip_code) }

  subject { described_class.new(address) }

  before do
    allow(WeatherClientService).to receive(:new).and_return(weather_client_service)
    allow(weather_client_service).to receive(:get_forecast).and_return(forecast_data)
    allow(WeatherForecast).to receive(:create_or_update_from_api).and_return(weather_forecast)
  end

  describe "#perform" do
    context "when address is invalid" do
      before do
        allow(address).to receive(:valid?).and_return(false)
        allow(address).to receive_message_chain(:errors, :full_messages, :join).and_return("Invalid address")
      end

      it "returns a failure result" do
        result = subject.perform
        expect(result.success?).to be false
        expect(result.error).to eq("Invalid address")
      end
    end

    context "when location cannot be found" do
      before do
        allow(address).to receive(:valid?).and_return(true)
        allow(Geocoder).to receive(:search).and_return([])
      end

      it "returns a failure result" do
        result = subject.perform
        expect(result.success?).to be false
        expect(result.error).to eq("Could not find location for that address")
      end
    end

    context "when everything is valid" do
      before do
        allow(address).to receive(:valid?).and_return(true)
        allow(address).to receive(:formatted_address).and_return("123 Main St, Boston, MA 02108")
        allow(Geocoder).to receive(:search).and_return([location])
      end

      it "returns a success result with weather data" do
        result = subject.perform
        expect(result.success?).to be true
        expect(result.data[:weather_forecast]).to eq(weather_forecast)
        expect(result.data[:location]).to eq(location)
      end

      it "caches the weather forecast" do
        cache_key = "weather_forecast_#{location.postal_code}"
        expect(Rails.cache).to receive(:exist?).with(cache_key)
        expect(Rails.cache).to receive(:fetch).with(cache_key, expires_in: 30.minutes)

        subject.perform
      end

      it "includes cache hit information in the result" do
        allow(Rails.cache).to receive(:exist?).and_return(true)

        result = subject.perform
        expect(result.data[:cache_hit]).to be true
      end
    end
  end
end

