class FavoritesController < ApplicationController
  def index
    @favorites = current_user.favorites
  end

  def edit
  end

  def update
  end

  def create
  end

  def delete
  end
end
