require 'open-uri'

class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[home result search]

  def home
  end

  def search
    if params[:query].present?
      url = "https://api.mapbox.com/geocoding/v5/mapbox.places/#{params[:query].parameterize}.json?access_token=#{ENV['MAPBOX_API_KEY']}"
      doc = JSON.parse(URI.open(url).read)
      @map_boundaries = doc['features'].find { |d| d['bbox'] }['bbox']
      @markers = Marker.where('longitude > ? AND latitude > ? AND longitude < ? AND latitude < ?', *@map_boundaries)
      if @markers.geocoded
        @map_markers = @markers.geocoded.map do |marker|
          {
            latitude: marker.latitude,
            longitude: marker.longitude
          }
        end
      end
    end

  end

  def result
    @markers = Marker.all
    if @markers.geocoded
      @map_markers = @markers.geocoded.map do |marker|
        {
          latitude: marker.latitude,
          longitude: marker.longitude
        }
      end
    end
  end
end
