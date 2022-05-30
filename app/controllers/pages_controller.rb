require 'open-uri'

class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[home result search custom_marker]
  skip_before_action :verify_authenticity_token

  def home
    # Remove navbar on home page
    @dnone = "d-none"
  end

  def search
    # when using the search bar, get map boundaries and weather from search location
    # show whole map when no search input

    respond_to do |format|
      format.html do
        if params[:query].present?
          search_by_address
          load_weather_by_coordinates(*@center)
        else
          @map_boundaries = [-200, -73, 200, 73]
        end
      end

      # when moving in the map, refresh map boundaries to dynamicly show markers on map
      format.json do
        @map_boundaries = params[:map_boundaries]
        markers_by_location
        marker_cards = marker_partials
        render json: { mapMarkers: @map_markers, markerCards: marker_cards }
      end
    end
  end

  def result
    # convert coordinates from string to float, returns an array
    @coordinates = params[:coordinates].map(&:to_f)

    # find assiciated marker with coordinates
    @marker = Marker.find_by_coordinates(*@coordinates).first
    load_weather_by_coordinates(*@coordinates)
  end

  def search_by_address
    # use mapbox api to find the center location and the boundaries of the location
    # mapbox map needs this to show the good markers
    url = "https://api.mapbox.com/geocoding/v5/mapbox.places/#{params[:query].parameterize}.json?access_token=#{ENV['MAPBOX_API_KEY']}"
    doc = JSON.parse(URI.open(url).read)
    @center = doc['features'].first['center']
    bounds = doc['features'].first['bbox']
    @map_boundaries = bounds || [@center[0] - 0.022, @center[1] - 0.022, @center[0] + 0.022, @center[1] + 0.022]
  end

  # uses the map boundaries to retrieve markers to display from the DB
  # info window generate the popup when clicking on a marker
  def markers_by_location
    @markers = Marker.where('longitude < ? AND latitude < ? AND longitude > ? AND latitude > ?', *@map_boundaries)
    @map_markers = @markers.map do |marker|
      { lon: marker.longitude, lat: marker.latitude, info_window: render_to_string(partial: "/pages/info_window.html.erb", locals: { marker: marker }) }
    end
  end

  # when putting a custom marker on the map, updates the overview, the map boundaries and all related components use marker's position
  def custom_marker
    respond_to do |format|
      format.json do
        coordinates = params[:coordinates]
        load_weather_by_coordinates(*coordinates)
        marker_info = { title: 'Custom marker', longitude: coordinates[0], latitude: coordinates[1] }
        info_window = render_to_string(partial: "/pages/info_window.html.erb", locals: { marker: Marker.new(marker_info) })
        overview = render_to_string(partial: '/pages/overview.html.erb', locals: { today: @meteo_prediction.first })
        custom_marker = {
          lon: coordinates[0],
          lat: coordinates[1],
          info_window: info_window
        }
        render json: { customMarker: custom_marker, overview: overview }
      end
    end
  end


  # uses API to get weather predictions for 14 days
  def load_weather_by_coordinates(longitude, latitude)
    api_key = ENV['visual_crossing']
    optional_element = "datetime,moonphase,sunrise,sunset,moonrise,moonset,temp,humidity,conditions,description,tempmax,tempmin,cloudcover"
    visualcrossing_url = "https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/timeline/#{latitude},#{longitude}?key=#{api_key}&include=days&elements=#{optional_element}"
    doc = JSON.parse(URI.open(visualcrossing_url).read)
    # index 0 is today - index 14 is in 2 weeks
    @meteo_prediction = doc['days'].map(&:symbolize_keys)
  end

  def marker_partials
    markers = @markers.first(10).map do |marker|
      render_to_string partial: '/pages/marker-card.html.erb', locals: { marker: marker }, layout: false
    end
    markers.join
  end
end
