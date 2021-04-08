require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end
   

  context '出品が可能なとき' do

    it 'すべての情報が正しければ出品できる' do
     expect(@item).to be_valid
    end

   it '商品名が４０字以内のときは出品登録可能'do
     @item.item_name="a"*40
     expect(@item).to be_valid
   end

   it '商品説明が1000字以内のときは出品登録可能'do
     @item.explain="a"*1000
     expect(@item).to be_valid
   end

   it '販売価格は¥300〜¥9,999,999までなら出品可能'do
     @item.price=5000
     expect(@item).to be_valid
   end

    it'販売価格は半角英数字のみ保存可能'do
     @item.price=11111
     expect(@item).to be_valid
    end
  end



  context '出品が不可なとき' do
    it '画像が空だと出品不可'do
    @item.image=nil
    @item.valid?
    expect(@item.errors.full_messages).to include("Image can't be blank")
    end 
    
    it '商品名が空だと出品不可'do
    @item.item_name=""
    @item.valid?
    expect(@item.errors.full_messages).to include("Item name can't be blank")
    end 

    it '商品名が41字以上のときは出品不可'do
     @item.item_name="a"*41
     @item.valid?
     expect(@item.errors.full_messages).to include("Item name is too long (maximum is 40 characters)")
    end
     
    it '商品の説明が空欄だと出品不可'do
    @item.explain=""
    @item.valid?
    expect(@item.errors.full_messages).to include("Explain can't be blank")
    end 
    
    it '商品の説明が1001字以上だと出品不可'do
    @item.explain="a"*1001
    @item.valid?
    expect(@item.errors.full_messages).to include("Explain is too long (maximum is 1000 characters)")
    end 
    

    it 'カテゴリーが未設定だと出品不可'do
    @item.category_id=1
    @item.valid?
    expect(@item.errors.full_messages).to include("Category must be other than 1")
    end 

    it '商品の状態が未設定だと出品不可'do
    @item.condition_id=1
    @item.valid?
    expect(@item.errors.full_messages).to include("Condition must be other than 1")
    end 

    it '配送料の負担が未設定だと出品不可'do
    @item.delivery_fee_id=1
    @item.valid?
    expect(@item.errors.full_messages).to include("Delivery fee must be other than 1")
    end 

    it '発送元の地域が未設定だと出品不可'do
    @item.prefecture_id=1
    @item.valid?
    expect(@item.errors.full_messages).to include("Prefecture must be other than 1")
    end 

    it '配送までの日程が未設定だと出品不可'do
    @item.delivery_date_id=1
    @item.valid?
    expect(@item.errors.full_messages).to include("Delivery date must be other than 1")
    end 

    it '金額が未入力だと出品不可'do
    @item.price=nil
    @item.valid?
    expect(@item.errors.full_messages).to include("Price can't be blank")
    end 

    it '¥300未満の価格なら出品不可'do
     @item.price=299
     @item.valid?
     expect(@item.errors.full_messages).to include("Price must be greater than or equal to 300")
   end

   it '¥10,000,000以上の価格なら出品不可'do
     @item.price=10000000
     @item.valid?
     expect(@item.errors.full_messages).to include("Price must be less than or equal to 9999999")
   end

   it'販売価格は半角数字以外は保存不可'do
    @item.price="123aaaaa"
    @item.valid?
    expect(@item.errors.full_messages).to include("Price is not a number")
   end

   it'販売価格は全角数字は保存不可'do
    @item.price="１２３４５６"
    @item.valid?
    expect(@item.errors.full_messages).to include("Price is not a number")
   end


  end

end