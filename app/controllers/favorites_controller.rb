class FavoritesController < ApplicationController
  before_action :set_item
  before_action :authenticate_user!

  def create
    if @item.user_id != current_user.id
      @favorite = Favorite.create(user_id: current_user.id, item_id: @item.id)
      respond_to do |format|
        format.js
      end
    end
  end

  def destroy
    @favorite = Favorite.find_by(user_id: current_user.id, item_id: @item.id)
    @favorite.destroy
    respond_to do |format|
      format.js
    end
  end

  private
  def set_item
    @item = Item.find(params[:item_id])
  end
end
