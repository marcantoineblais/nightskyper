require 'open-uri'

class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[home result search]
  skip_before_action :verify_authenticity_token


  def home
  end

  def search
    respond_to do |format|
      format.html do
        if params[:query].present?
          search_by_address
        end
      end

      format.json do
        @map_boundaries = params[:map_boundaries]
        @center = params[:center]
        markers_by_location
        render json: { map_markers: @map_markers }
      end
    end
    @markers = Marker.all
  end

  def result
    if params[:query].present?
      search_by_address
      markers_by_location
    end
  end

  def search_by_address
    url = "https://api.mapbox.com/geocoding/v5/mapbox.places/#{params[:query].parameterize}.json?access_token=#{ENV['MAPBOX_API_KEY']}"
    doc = JSON.parse(URI.open(url).read)
    @center = doc['features'].first['center']
    bounds = doc['features'].first['bbox']
    @map_boundaries = bounds || [@center[0] - 0.022, @center[1] - 0.022, @center[0] + 0.022, @center[1] + 0.022]
  end

  def markers_by_location
    @markers = Marker.where('longitude < ? AND latitude < ? AND longitude > ? AND latitude > ?', *@map_boundaries)
    @map_markers = @markers.map { |marker| [marker.longitude, marker.latitude] }
  end

  def load_weather_by_address(longitude, latitude)
    weather_url = "https://api.openweathermap.org/data/2.5/weather?appid=#{ENV['open_weather']}&lat=#{latitude}&lon=#{longitude}"
    doc = JSON.parse(URI.open(weather_url).read)
    # Varible to show
    weather_temp = doc['main']['temp']
    @weather_descrip = doc['weather'].first['description']
    @weather_humidity = doc['main']['humidity']
    @temp_in_degre = ((weather_temp - 273.15) * 1.000000).round(2)
  end
end
