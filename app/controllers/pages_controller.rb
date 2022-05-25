require 'open-uri'

class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[home result search]

  def home
  end

  def search
    if params[:query].present?
      search_by_address
      load_weather_by_address(@center[0], @center[1])
      @map_markers = @markers.map { |marker| [marker.longitude, marker.latitude] }
    end
  end

  def result
    if params[:query].present?
      search_by_address
      @map_markers = @markers.map { |marker| [marker.longitude, marker.latitude] }
    end
  end

  def search_by_address
    url = "https://api.mapbox.com/geocoding/v5/mapbox.places/#{params[:query].parameterize}.json?access_token=#{ENV['MAPBOX_API_KEY']}"
    doc = JSON.parse(URI.open(url).read)
    @center = doc['features'].first['center']
    bounds = doc['features'].first['bbox']
    @map_boundaries = bounds || [@center[0] - 0.022, @center[1] - 0.022, @center[0] + 0.022, @center[1] + 0.022]
    @markers = Marker.where('longitude > ? AND latitude > ? AND longitude < ? AND latitude < ?', *@map_boundaries)
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
