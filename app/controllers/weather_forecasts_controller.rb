class WeatherForecastsController < ApplicationController
  before_action :set_weather_forecast, only: [:index, :search]

  def index
  end

  def search
    result = WeatherLookupService.new(Address.new(params[:address])).perform

    if result.success?
      @weather_forecast = result.data[:weather_forecast]
      @cache_hit = result.data[:cache_hit]
      @latitude = result.data[:location].latitude
      @longitude = result.data[:location].longitude
      @zipcode = result.data[:location].postal_code
    else
      flash.now[:alert] = result.error
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
