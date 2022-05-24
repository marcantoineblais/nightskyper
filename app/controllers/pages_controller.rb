class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[home result search]

  def home
  end

  def search
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
