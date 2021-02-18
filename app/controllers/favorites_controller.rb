class FavoritesController < ApplicationController
  before_action :authenticate_user!

  def create
    @good = Good.find(params[:good_id])
    favorite = @good.favorites.new(user_id: current_user.id)
    favorite.save
  end

  def destroy
    @good = Good.find(params[:good_id])
    favorite = @good.favorites.find_by(user_id: current_user.id)
    favorite.destroy
  end
end
