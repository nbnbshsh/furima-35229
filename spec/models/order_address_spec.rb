require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  before do
      @user = FactoryBot.create(:user)
      @item = FactoryBot.create(:item)
      @order_address = FactoryBot.build(:order_address, user_id: @user.id, item_id: @item.id)
      sleep 0.1
  end

  context '購入できる場合' do
    it '情報を全て正しく記載した場合' do
      expect(@order_address).to be_valid
    end

    it '建物名は空でも購入できる'do
      @order_address.building_name=""
      expect(@order_address).to be_valid
    end
  end

  context '購入できない場合' do
    it 'クレジットカード情報が空のとき購入不可' do
      @order_address.token = ''
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Token can't be blank")
    end

    it '郵便番号が空白のとき購入不可' do
      @order_address.postal_code = ''
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Postal code can't be blank")
    end

    it '都道府県が未選択のとき購入不可' do
      @order_address.prefecture_id = 1
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include('Prefecture must be other than 1')
    end

    it '市区町村が空欄のとき購入不可' do
      @order_address.municipality = ''
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Municipality can't be blank")
    end

    it '番地が空蘭のとき購入不可' do
      @order_address.address = ''
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Address can't be blank")
    end

    it '電話番号が空蘭のとき購入不可' do
      @order_address.telephone_number = ''
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Telephone number can't be blank")
    end

    it 'user_idが空のとき登録できない' do
      @order_address.user_id = ''
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("User can't be blank")
    end

    it 'item_idが空のとき登録できない' do
      @order_address.item_id = ''
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Item can't be blank")
    end

    it '郵便番号がハイフンなしの７文字のとき購入不可' do
      @order_address.postal_code = '1234567'
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include('Postal code is invalid')
    end

    it '郵便番号が3文字-4文字の合計7文字じゃない時購入不可' do
      @order_address.postal_code = '123-456'
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include('Postal code is invalid')
    end

    it '電話番号が12文字以上のとき購入不可' do
      @order_address.telephone_number = '080123456789'
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include('Telephone number is invalid')
    end

    it '電話番号がハイフンなどの数字以外が混ざるとき購入不可' do
      @order_address.telephone_number = '080-1234-5678'
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include('Telephone number is invalid')
    end
  end
end
