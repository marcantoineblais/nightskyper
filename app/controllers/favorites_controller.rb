class FavoritesController < ApplicationController
  skip_before_action :authenticate_user!, only: :create
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
        marker = Marker.find(params[:marker_id])
        favorite = Favorite.new(marker: marker, user: current_user)
        if favorite.save
          render = render_to_string partial: '/pages/remove_favorites.html.erb', locals: { marker: marker, path: marker_favorites_path(marker) }, layout: false
          saved = true
        else
          render = new_user_session_path
          saved = false
        end
        render json: { saved: saved, render: render }
      end
    end
  end

  def destroy
    respond_to do |format|
      format.html do
        marker = Marker.find(params[:marker_id])
        favorite = Favorite.find_by(marker: marker)
        favorite.destroy
        redirect_to favorites_path
      end
      format.json do
        marker = Marker.find(params[:marker_id])
        favorite = Favorite.find_by(marker: marker)
        favorite.destroy
        render = render_to_string partial: '/pages/add_favorites.html.erb', locals: { marker: marker, path: marker_favorites_path(marker) }, layout: false
        render json: { render: render }
      end
    end
  end
end
