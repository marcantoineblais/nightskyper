class ReviewsController < ApplicationController
  def new
    @review = Review.new
    @marker = Marker.find(params[:marker_id])
  end

  def create
    @marker = Marker.find(params[:marker_id])
    @review = Review.new(review_params)
    @review.user = current_user
    @review.marker = @marker

    if @review.save
      redirect_to result_path(coordinates: [@marker.longitude, @marker.latitude])
    else
      render :new
    end
  end

  private

  def review_params
    params.require(:review).permit(:rating, :content, :date, :photos)
  end
end
