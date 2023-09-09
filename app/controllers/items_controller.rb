class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_items, only: [:new, :create, :edit, :update]
  def index
    @items = Item.includes(:user).order("created_at DESC")
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.create(item_params)
    if @item.save
      redirect_to "/"
    else
      render "new", status: :unprocessable_entity
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to item_path
    else
      render "edit", status: :unprocessable_entity
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :explanation, :category_id, :condition_id, :delivery_charge_id, :delivery_city_id, :delivery_day_id, :price, :image).merge(user_id: current_user.id)
  end

  def set_items
    @categorys = Category.all
    @conditions = Condition.all
    @delivery_charges = DeliveryCharge.all
    @delivery_citys = DeliveryCity.all
    @delivery_days = DeliveryDay.all
  end
end
