require 'rails_helper'

RSpec.describe WeatherClientService do
  describe '#get_forecast' do
    let(:service) { described_class.new }
    let(:latitude) { 42.4184 }
    let(:longitude) { -71.1062 }

    let(:mock_response) do
      {
        "location" => {
          "name" => "Medford",
          "region" => "Massachusetts"
        },
        "current" => {
          "temp_f" => 30.9,
          "last_updated" => "2024-03-14 12:00",
          "feelslike_f" => 28.5,
          "wind_mph" => 8.5,
          "condition" => {
            "text" => "Sunny",
            "icon" => "//cdn.weatherapi.com/weather/64x64/day/113.png"
          }
        },
        "forecast" => {
          "forecastday" => [
            {
              "day" => {
                "maxtemp_f" => 38.1,
                "mintemp_f" => 20.1
              }
            }
          ]
        }
      }
    end

    before do
      stub_request(:get, "https://api.weatherapi.com/v1/forecast.json")
        .with(
          headers: {
            'Accept'=>'*/*',
            'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
            'User-Agent'=>'Ruby'
          },
          query: {
            q: "#{latitude},#{longitude}",
            key: Rails.application.credentials.weatherapi[:api_key]
          }
        )
        .to_return(
          status: 200,
          body: mock_response.to_json,
          headers: { 'Content-Type' => 'application/json' }
        )
    end

    it 'returns parsed forecast data' do
      result = service.get_forecast(latitude, longitude)

      expect(result).to eq({
        city: "Medford",
        state: "Massachusetts",
        current_temp: 30.9,
        last_updated: "2024-03-14 12:00",
        feels_like: 28.5,
        wind_speed: 8.5,
        condition: "Sunny",
        condition_icon: "//cdn.weatherapi.com/weather/64x64/day/113.png",
        high_temp: 38.1,
        low_temp: 20.1
      })
    end

    context 'when the API request fails' do
      before do
        stub_request(:get, "https://api.weatherapi.com/v1/forecast.json")
          .with(
            query: {
              q: "#{latitude},#{longitude}",
              key: Rails.application.credentials.weatherapi[:api_key]
            }
          )
          .to_return(status: 500, body: "Internal Server Error")
      end

      it 'returns nil and logs the error' do
        expect(Rails.logger).to receive(:error).with(/Weather API Error: 500/)
        result = service.get_forecast(latitude, longitude)
        expect(result).to be_nil
      end
    end
  end
end
