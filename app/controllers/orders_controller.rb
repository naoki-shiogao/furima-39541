class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :current_user?
  before_action :set_orders
  before_action :seller_soldout, only: [:index]
  before_action :payjp_public_key, only: [:index, :create]

  def index
    @order_form = OrderForm.new
  end

  def create
    @order_form = OrderForm.new(order_params)
    if @order_form.valid?
      pay_item
      @order_form.save
      redirect_to root_path
    else
      gon.public_key = ENV['PAYJP_PUBLIC_KEY']
      render 'index', status: :unprocessable_entity
    end
  end

  private

  def current_user?
    @item = Item.find(params[:item_id])
    return unless @item.user_id == current_user.id

    redirect_to '/'
  end

  def payjp_public_key
    gon.public_key = ENV['PAYJP_PUBLIC_KEY']
  end

  def set_orders
    @prefectures = Prefecture.all
  end

  def order_params
    params.require(:order_form).permit(:postal_code, :prefecture_id, :city, :house_number, :building_name, :telephone_number)
          .merge(
            item_id: params[:item_id], user_id: current_user.id, token: params[:token]
          )
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price, # 商品の値段
      card: order_params[:token], # カードトークン
      currency: 'jpy' # 通貨の種類（日本円）
    )
  end

  def seller_soldout
    return unless @item.user == current_user || @item.order.present?

    redirect_to '/'
  end
end
