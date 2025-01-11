class WeatherForecastsController < ApplicationController
  before_action :set_weather_forecast, only: [:index, :search]

  def index
  end

  def search
    result = WeatherLookupService.new(Address.new(params[:address])).perform

    if address.valid?
      results = Geocoder.search(address.formatted_address)
      if location = results.first
        @latitude = location.latitude
        @longitude = location.longitude
        @zipcode = location.postal_code

        @cache_hit = Rails.cache.exist?("weather_forecast_#{@zipcode}")

        @weather_forecast = Rails.cache.fetch("weather_forecast_#{@zipcode}", expires_in: 10.seconds) do
          zip_code = ZipCode.find_or_create_by(code: @zipcode)
          weather_service = WeatherService.new
          forecast_data = weather_service.get_forecast(@latitude, @longitude)

          if forecast_data
            WeatherForecast.create_or_update_from_api(forecast_data, zip_code)
          else
            []
          end
        end
      else
        flash.now[:alert] = "Could not find location for that address"
      end
    else
      flash.now[:alert] = address.errors.full_messages.join(', ')
    end

    render :index
  end

  private

  def set_weather_forecast
    @weather_forecasts = Rails.cache.fetch("weather_forecasts", expires_in: 5.seconds) do
      WeatherForecast.limit(3).includes(:zip_code).order(created_at: :desc)
    end
  end
end
