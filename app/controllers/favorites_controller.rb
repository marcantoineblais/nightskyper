class FavoritesController < ApplicationController
  def index
    @favorites = current_user.favorites
  end

  def edit
  end

  def update
  end

  def create
    marker = Marker.find(params[:marker_id])
    Favorite.create(marker: marker, user: current_user)
    redirect_back(fallback_location: search_path)
  end

  def destroy
    marker = Marker.find(params[:marker_id])
    favorite = Favorite.find_by(marker: marker)
    favorite.destroy
    redirect_back(fallback_location: search_path)
  end
end
