class ItemsController < ApplicationController
  def index
    @items = Item.all
  end

  def new
    @item = Item.new
    @category = Category.all
    @condition = Condition.all
    @delivery_charge = DeliveryCharge.all
    @delivery_city = DeliveryCity.all
    @delivery_day = DeliveryDay.all
  end

  def create
    Item.create(item_params)
    redirect_to root_path
  end

  private

  def item_params
    params.require(:item).premit(:name, :explanation, :category_id, :condition_id, :delivery_charge_id, :delivery_city_id, :delivery_day_id, :price, :image).merge(user_id: current_user.id)
  end
end
