class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_items, only: [:new, :create, :edit, :update]
  before_action :set_item_find, only: [:show, :edit, :update, :destroy, :correct_user]
  before_action :correct_user, only: [:edit, :update]
  before_action :set_item_find, only: [:show, :edit, :update,:destroy]
  def index
    @items = Item.includes(:user).order('created_at DESC')
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.create(item_params)
    if @item.save
      redirect_to '/'
    else
      render 'new', status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to item_path
    else
      render 'edit', status: :unprocessable_entity
    end
  end

  def destroy
    if @item.user_id == current_user.id
      @item.destroy
      redirect_to root_path
    else
      redirect_to root_path
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :explanation, :category_id, :condition_id, :delivery_charge_id, :delivery_city_id,
                                 :delivery_day_id, :price, :image).merge(user_id: current_user.id)
  end

  def set_item_find
    @item = Item.find(params[:id])
  end

  def correct_user
    return unless @item.user != current_user || @item.order.present?

    redirect_to '/'
  end

  def set_items
    @categorys = Category.all
    @conditions = Condition.all
    @delivery_charges = DeliveryCharge.all
    @delivery_citys = DeliveryCity.all
    @delivery_days = DeliveryDay.all
  end
end
