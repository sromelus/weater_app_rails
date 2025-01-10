class WeatherForecastsController < ApplicationController
  def index
    @weather_forecasts = WeatherForecast.all
  end

  def show
    # debugger
  end

  def search
    if params[:address].present?
      results = Geocoder.search(params[:address])
      if location = results.first
        @latitude = location.latitude
        @longitude = location.longitude
        @zipcode = location.postal_code


        zip_code = ZipCode.find_or_create_by(code: @zipcode)
        weather_service = WeatherService.new
        forecast_data = weather_service.get_forecast(@latitude, @longitude)

        @weather_forecasts = if forecast_data
          WeatherForecast.create_or_update_from_api(forecast_data, zip_code)
        else
          []
        end
      else
        flash.now[:alert] = "Could not find location for that address"
        @weather_forecasts = []
      end
    else
      @weather_forecasts = WeatherForecast.all
    end

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
