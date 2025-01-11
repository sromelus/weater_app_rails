require "ostruct"

class WeatherLookupService
  def initialize(address)
    @address = address
  end

  def perform
    return failure_result(address.errors.full_messages.join(", ")) unless address.valid?

    location = find_location
    return failure_result("Could not find location for that address") unless location

    fetch_weather_data(location)
  end

  private

  attr_reader :address

  def find_location
    Geocoder.search(address.formatted_address).first
  end

  def fetch_weather_data(location)
    cache_key = "weather_forecast_#{location.postal_code}"
    cache_hit = Rails.cache.exist?(cache_key)

    weather_forecast = Rails.cache.fetch(cache_key, expires_in: 30.minutes) do
      zip_code = ZipCode.find_or_create_by(code: location.postal_code)
      forecast_data = WeatherClientService.new.get_forecast(location.latitude, location.longitude)

      forecast_data ? WeatherForecast.create_or_update_from_api(forecast_data, zip_code) : []
    end

    success_result(
      weather_forecast: weather_forecast,
      cache_hit: cache_hit,
      location: location
    )
  end

  def success_result(data)
    OpenStruct.new(success?: true, data: data)
  end

  def failure_result(error)
    OpenStruct.new(success?: false, error: error)
  end
end
