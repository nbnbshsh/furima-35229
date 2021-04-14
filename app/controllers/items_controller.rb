class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index,:show]
  before_action :set_items, only: [:show, :edit, :update, :destroy,:order]
  before_action :editting_items, only: [:edit, :update, :destroy,:order]
  
  
  def index
    @items = Item.all.order(created_at: 'DESC')
  end

  def new
    @item = Item.new
  end

  def show
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to item_path(@item.id)
    else
      render :edit
    end
  end

  def destroy
    @item.destroy
    redirect_to root_path
  end

  def order # 購入する時のアクションを定義
    binding.pry
    redirect_to new_card_path and return unless current_user.card.present?

    Payjp.api_key = ENV["PAYJP_SECRET_KEY"] 
    customer_token = current_user.card.customer_token # ログインしているユーザーの顧客トークンを定義
    Payjp::Charge.create(
      amount: @item.price, # 商品の値段
      customer: customer_token, # 顧客のトークン
      currency: 'jpy' # 通貨の種類（日本円）
      )
    ItemOrder.create(item_id: params[:id]) # 商品のid情報を「item_id」として保存する
    redirect_to root_path

  end
 

  private

  def item_params
    params.require(:item).permit(:item_name, :explain, :category_id, :condition_id, :delivery_fee_id, :prefecture_id, :delivery_date_id,
                                 :price, images: []).merge(user_id: current_user.id)
  end

  def set_items
    @item = Item.find(params[:id])
  end

  def editting_items
    if current_user.id == @item.user_id || @item.item_order != nil
     return redirect_to root_path 
    end
  end

  
end
