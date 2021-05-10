class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index,:show]
  before_action :set_items, only: [:show,:edit, :update, :destroy,:order]
  before_action :editting_items, only: [:edit, :update, :destroy]
  before_action :order_editting_items, only: [:edit, :update, :destroy,:order]
  before_action :search_item, except: [:destroy,:order]

 
  
  def index
    @items = Item.all.order(created_at: 'DESC')
  end

  def search_product
    @results = @i.result
  end

  def search
    return nil if params[:keyword] == ""
    tag = Tag.where(['name LIKE ?', "%#{params[:keyword]}%"] )
    render json:{ keyword: tag }
  end

  def new
    @item = ItemsTag.new
  end

  def show
    @items = Item.all #ヘッダーの検索機能用に必要
    @messages = Message.all
    @message = Message.new
  end

  def create
    @item = ItemsTag.new(item_params)
    if @item.valid?
      @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @item.update(item_only)
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
    if current_user.id == @item.user_id
      return redirect_to root_path 
    end

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
    params.require(:items_tag).permit(:name,:item_name, :explain, :category_id, :condition_id, :delivery_fee_id,:prefecture_id, :delivery_date_id,:price,images: []).merge(user_id: current_user.id)
  end

  def item_only
    params.require(:item).permit(:item_name, :explain, :category_id, :condition_id, :delivery_fee_id,:prefecture_id, :delivery_date_id,:price,images: [])
  end

  def set_items
    @item = Item.find(params[:id])
  end

  def editting_items
    if current_user.id != @item.user_id
     return redirect_to root_path 
    end
  end

  def order_editting_items
    if @item.item_order != nil
     return redirect_to root_path 
    end
  end
  
  def search_item
    @i = Item.ransack(params[:q])  # 検索オブジェクトを生成
  end

end
