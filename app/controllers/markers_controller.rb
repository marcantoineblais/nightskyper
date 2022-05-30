class MarkersController < ApplicationController

  def new
    # retrieve coordinates from params and convert to float => returns an array
    @coordinates = params[:coordinates].map(&:to_f)
    # send new marker for forms
    @marker = Marker.new
  end

  def create
    # create method uses coordinates instead of ID for redirection after successful save
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
    params.require(:marker).permit(:title, :description, :latitude, :longitude, photos: [])
  end
end
