class WeatherClientService
  include HTTParty
  base_uri "api.weatherapi.com/v1"

  def initialize
    @api_key = Rails.application.credentials.weatherapi[:api_key]
  end

  def get_forecast(latitude, longitude)
    response = self.class.get("/forecast.json", query: {
      q: "#{latitude},#{longitude}",
      key: @api_key
    })

    if response.success?
      parse_forecast_response(response)
    else
      Rails.logger.error("Weather API Error: #{response.code} - #{response.body}")
      nil
    end
  end

  private

  def parse_forecast_response(response)
    data = response.parsed_response
    {
        city: data.dig("location", "name"),
        state: data.dig("location", "region"),
        current_temp: data.dig("current", "temp_f"),
        last_updated: data.dig("current", "last_updated"),
        feels_like: data.dig("current", "feelslike_f"),
        wind_speed: data.dig("current", "wind_mph"),
        condition: data.dig("current", "condition", "text"),
        condition_icon: data.dig("current", "condition", "icon"),
        high_temp: data.dig("forecast", "forecastday").first.dig("day", "maxtemp_f"),
        low_temp: data.dig("forecast", "forecastday").first.dig("day", "mintemp_f")
    }
  end


  def mock_forecast_response
    {
      "location" => { "name" => "Medford", "region" => "Massachusetts" },
      "current" => { "temp_f" => 30.9, "condition" => { "text" => "Sunny", "icon" => "//cdn.weatherapi.com/weather/64x64/day/113.png" } },
      "forecast" => { "forecastday" => [ { "day" => { "maxtemp_f" => 38.1, "mintemp_f" => 20.1 } } ] }
    }
  end
end
