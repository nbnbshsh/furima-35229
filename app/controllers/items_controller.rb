class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_items, only: [:show, :edit, :update, :destroy]
  before_action :editting_items, only: [:edit, :update, :destroy]
  
  
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
    redirect_to root_path unless @item.order.nil?
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

  private

  def item_params
    params.require(:item).permit(:item_name, :explain, :category_id, :condition_id, :delivery_fee_id, :prefecture_id, :delivery_date_id,
                                 :price, :image).merge(user_id: current_user.id)
  end

  def set_items
    @item = Item.find(params[:id])
  end

  def editting_items
    redirect_to root_path unless current_user.id == @item.user_id
  end

  
end
