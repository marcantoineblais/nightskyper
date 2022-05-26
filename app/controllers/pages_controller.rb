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
    coordinates = JSON.parse(params[:coordinates])
    if coordinates
      # search_by_address
      # markers_by_location
      load_weather_by_address(coordinates[0], coordinates[1])
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
    api_key = ENV['visual_crossing']
    optional_element = "datetime,moonphase,sunrise,sunset,moonrise,moonset,temp,humidity,conditions,description,tempmax,tempmin,cloudcover"
    visualcrossing_url = "https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/timeline/#{latitude},#{longitude}?key=#{api_key}&include=days&elements=#{optional_element}"
    doc = JSON.parse(URI.open(visualcrossing_url).read)
    data_from_visualcrossing = doc['days']
    # Variable for every day
    @today = data_from_visualcrossing[0].symbolize_keys
    @tomorrow = data_from_visualcrossing[1].symbolize_keys
    @today_plus_two = data_from_visualcrossing[2].symbolize_keys
    @today_plus_three = data_from_visualcrossing[3].symbolize_keys
    @today_plus_four = data_from_visualcrossing[4].symbolize_keys
    @today_plus_five = data_from_visualcrossing[5].symbolize_keys
    @today_plus_six = data_from_visualcrossing[6].symbolize_keys
    @today_plus_seven = data_from_visualcrossing[7].symbolize_keys
  end
end
