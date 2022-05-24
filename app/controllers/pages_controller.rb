class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[home result search]

  def home
  end

  def search
  end

  def result
  end
end
