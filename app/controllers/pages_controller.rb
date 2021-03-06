require 'open-uri'
require 'nokogiri'
require_relative '../../weather-conditions'

class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[home result search custom_marker marker_info overview render_overview]
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
          overview(*@center)
          @marker = Marker.new(longitude: @center.first, latitude: @center.last)
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
    search_by_coordinates(*@coordinates)
    # find assiciated marker with coordinates
    @marker = Marker.find_by_coordinates(*@coordinates).first || Marker.new(title: 'Custom marker', longitude: @coordinates[0], latitude: @coordinates[1])
    @path = @marker.id ? marker_favorites_path(@marker) : nil
    overview(@marker.longitude, @marker.latitude)
    @review = Review.new
  end

  def search_by_address
    # use mapbox api to find the center location and the boundaries of the location
    # mapbox map needs this to show the good markers
    url = "https://api.mapbox.com/geocoding/v5/mapbox.places/#{params[:query].parameterize}.json?access_token=#{ENV['MAPBOX_API_KEY']}"
    doc = JSON.parse(URI.open(url).read)
    @place_name = doc['features'].first['place_name']
    @center = doc['features'].first['center']
    bounds = doc['features'].first['bbox']
    @map_boundaries = bounds || [@center[0] - 0.022, @center[1] - 0.022, @center[0] + 0.022, @center[1] + 0.022]
  end

  def search_by_coordinates(longitude, latitude)
    url = "https://api.mapbox.com/geocoding/v5/mapbox.places/#{longitude},#{latitude}.json?access_token=#{ENV['MAPBOX_API_KEY']}"
    doc = JSON.parse(URI.open(url).read)
    @doc = doc['features']
    place_name_list = []
    @doc.each do |feature|
      place_name_list << feature['place_name']
    end
    @place_name = place_name_list[-3]
  end

  # uses the map boundaries to retrieve markers to display from the DB
  # info window generate the popup when clicking on a marker
  def markers_by_location
    @markers = Marker.where('longitude < ? AND latitude < ? AND longitude > ? AND latitude > ?', *@map_boundaries)
    @map_markers = @markers.map do |marker|
      { id: marker.id, lon: marker.longitude, lat: marker.latitude, info_window: render_to_string(partial: "/pages/info_window.html.erb", locals: { marker: marker }) }
    end
  end

  # when putting a custom marker on the map, updates the overview, the map boundaries and all related components use marker's position
  def marker_info
    respond_to do |format|
      format.json do
        @marker = Marker.find(params[:id].to_i)
        info_window = render_to_string(partial: "/pages/info_window.html.erb", locals: { marker: @marker })
        marker = {
          id: @marker.id,
          lon: @marker.longitude,
          lat: @marker.latitude,
          info_window: info_window
        }
        render json: { marker: marker }
      end
    end
  end

  def custom_marker
    respond_to do |format|
      format.json do
        @marker = Marker.new(title: 'Custom marker', longitude: params[:coordinates][0].to_f, latitude: params[:coordinates][1].to_f)
        info_window = render_to_string(partial: "/pages/info_window.html.erb", locals: { marker: @marker })
        form = render_to_string partial: '/pages/marker-form.html.erb', locals: { marker: @marker }, layout: false
        custom_marker = {
          lon: @marker.longitude,
          lat: @marker.latitude,
          info_window: info_window
        }
        render json: { customMarker: custom_marker, form: form }
      end
    end
  end

  # uses API to get weather predictions for 14 days
  def load_weather_by_coordinates(longitude, latitude)
    api_key = ENV['visual_crossing']
    optional_element = "datetime,moonphase,sunrise,sunset,moonrise,moonset,temp,humidity,conditions,description,tempmax,tempmin,cloudcover"
    visualcrossing_url = "https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/timeline/#{latitude},#{longitude}?key=#{api_key}&include=days&elements=#{optional_element}"
    begin
      doc = JSON.parse(URI.open(visualcrossing_url).read)
      # index 0 is today - index 14 is in 2 weeks
      @meteo_prediction = doc['days'].map(&:symbolize_keys)
      @weather = WeatherCondition.new
    rescue
      flash[:notice] = "Meteo data currently unavailable"
    end
  end

  def fetch_bortle(longitude, latitude)
    bortle_url = "https://clearoutside.com/forecast/#{latitude}/#{longitude}"

    selector = "span[class*=btn-bortle] strong:nth-child(3)"
    begin
      html_file = URI.open(bortle_url).read
      html_doc = Nokogiri::HTML(html_file)

      @bortle = html_doc.search(selector).text.strip
    rescue
      flash[:notice] = "Bortle class currently unavailable"
    end
  end

  def marker_partials
    markers = @markers.map do |marker|
      render_to_string partial: '/pages/marker-card.html.erb', locals: { marker: marker, path: marker_favorites_path(marker) }, layout: false
    end
    markers.join
  end

  def overview(longitude, latitude)
    load_weather_by_coordinates(longitude, latitude)
    fetch_bortle(longitude, latitude)
    search_by_coordinates(longitude, latitude)
  end

  def render_overview
    respond_to do |format|
      format.json do
        marker = params[:marker]
        coordinates = marker['lon'].to_f, marker['lat'].to_f
        if marker['id']
          @marker = Marker.find(marker[:id])
        else
          @marker = Marker.new(title: 'Custom marker', longitude: coordinates[0], latitude: coordinates[1])
        end
        overview(*coordinates)
        path = @marker.id ? marker_favorites_path(@marker) : nil
        overview = render_to_string(partial: '/pages/overview.html.erb', locals: { day: @meteo_prediction.first, place_name: @place_name, bortle: @bortle, marker: @marker, path: path})
        render json: { overview: overview }
      end
    end
  end
end
