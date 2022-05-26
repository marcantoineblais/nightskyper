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
          @map_markers = @markers.map { |marker| [marker.longitude, marker.latitude] }
        end
      end

      format.json do
      end
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
end
