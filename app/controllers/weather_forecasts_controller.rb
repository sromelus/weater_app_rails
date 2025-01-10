class WeatherForecastsController < ApplicationController
  def index
    @weather_forecasts = WeatherForecast.all
  end

  def show
    # debugger
  end

  def search
    # Assuming lat/lng are passed as parameters
    # if params[:latitude].present? && params[:longitude].present?
      results = Geocoder.search([37.7749, -122.4194])
      @zipcode = results.first&.postal_code
      @weather_forecasts = WeatherForecast.where(zip_code_id: ZipCode.find_by(code: @zipcode))
    # else
    #   @weather_forecasts = WeatherForecast.all
    # end
  
    render :index
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
