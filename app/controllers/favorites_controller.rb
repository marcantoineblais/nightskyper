class FavoritesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    @favorites = current_user.favorites
  end

  def edit
  end

  def update
  end

  def create
    respond_to do |format|

      format.html do
        marker = Marker.find(params[:marker_id])
        Favorite.create(marker: marker, user: current_user)
        redirect_to favorites_path
      end

      format.json do
        if current_user
          marker = Marker.find(params[:marker_id])
          Favorite.create(marker: marker, user: current_user)
          marker_card = render_to_string partial: '/pages/marker-card.html.erb', locals: { marker: marker, path: marker_favorites_path(marker) }, layout: false
          render json: { markerCard: marker_card }
        else
          redirect_to new_user_session_path
        end
      end
    end
  end

  def destroy
    respond_to do |format|
      format.html do
        marker = Marker.find(params[:marker_id])
        favorite = Favorite.find_by(marker: marker)
        favorite.destroy
        redirect_to search_path
      end
      format.json do
        marker = Marker.find(params[:marker_id])
        favorite = Favorite.find_by(marker: marker)
        favorite.destroy
        marker_card = render_to_string partial: '/pages/marker-card.html.erb', locals: { marker: marker, path: marker_favorites_path(marker) }, layout: false
        render json: { markerCard: marker_card }
      end
    end
  end
end
