class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :current_user?

  def index
    @item = Item.find(params[:item_id])
  end



  private

  def current_user?
    @item = Item.find(params[:item_id])
    if @item.user_id == current_user.id
      redirect_to "/"
    end
  end
end
