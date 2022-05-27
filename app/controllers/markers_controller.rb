class MarkersController < ApplicationController
  def new
    @coordinates = params[:coordinates].map(&:to_f)
    @marker = Marker.new
  end

  def create
    @marker = Marker.new(marker_params)
    @marker.user = current_user
    if @marker.save
      redirect_to result_path(coordinates: [@marker.longitude, @marker.latitude])
    else
      @coordinates = [@marker.longitude, @marker.latitude]
      render :new
    end
  end

  private

  def marker_params
    params.require(:marker).permit(:title, :description, :photo, :latitude, :longitude)
  end
end
