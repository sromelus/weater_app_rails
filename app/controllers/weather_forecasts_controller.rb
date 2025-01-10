class WeatherForecastsController < ApplicationController
  def index
    @weather_forecasts = WeatherForecast.all
  end

  def show
    # debugger
  end

  def search
    @weather_forecasts = WeatherForecast.all
    render :index
    # respond_to do |format|
    #   format.html
    #   format.js
    # end
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
