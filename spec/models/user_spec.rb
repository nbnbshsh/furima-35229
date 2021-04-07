require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end
   

  context 'ユーザ登録ができる時' do
    
    it 'ニックネームが必須であること' do
      @user.nickname="aaaaa"
      expect(@user).to be_valid
     end

     it 'メールアドレスが必須であること'do
    @user.email='aaaa@aaaa'
    expect(@user).to be_valid
   end

   it 'メールアドレスは、@を含む必要があること'do
    @user.email='test@test.com'
    expect(@user).to be_valid
   end

   it 'パスワードは、6文字以上での入力が必須であること（6文字が入力されていれば、登録が可能なこと)' do
    @user.password="111aaa"
    @user.password_confirmation="111aaa"
    expect(@user).to be_valid
   end
   
   it 'パスワードは、半角英数字混合での入力が必須であること（半角英数字が混合されていれば、登録が可能なこと)' do
    @user.password="1234asdf"
    @user.password_confirmation="1234asdf"
    expect(@user).to be_valid
  end


  it 'パスワードは、確認用を含めて2回入力すること' do
   @user.password="222aaa"
   @user.password_confirmation="222aaa"
   expect(@user).to be_valid
  end

  it 'パスワードとパスワード（確認用）は、値の一致が必須であること' do
   @user.password="222aaa"
   @user.password_confirmation="222aaa"
   expect(@user).to be_valid
  end

  it 'ユーザー本名は、名字と名前がそれぞれ必須であること' do
    @user.first_name="佐藤"
    @user.last_name="太朗"
    expect(@user).to be_valid
   end

   it 'ユーザー本名は、全角（漢字・ひらがな・カタカナ）での入力が必須であること（漢字の場合）' do
    @user.first_name="佐藤"
    @user.last_name="太郎"
    expect(@user).to be_valid
  end

  it 'ユーザー本名は、全角（漢字・ひらがな・カタカナ）での入力が必須であること（ひらがなの場合）' do
    @user.first_name="さとう"
    @user.last_name="たろう"
    expect(@user).to be_valid
  end

  it 'ユーザー本名は、全角（漢字・ひらがな・カタカナ）での入力が必須であること（カタカナの場合）' do
    @user.first_name="サトウ"
    @user.last_name="タロウ"
    expect(@user).to be_valid
  end

  it 'ユーザー本名のフリガナは、名字と名前がそれぞれ必須で全角（カタカナ）での入力あること' do
    @user.first_furigana="サトウ"
    @user.last_furigana="タロウ"
    expect(@user).to be_valid
  end

  it '生年月日が必須であること' do
    @user.birthday="2020-02-02"
    expect(@user).to be_valid
   end
   
  end


  
  context 'ユーザ登録ができない時' do

    it 'メールアドレスが一意性であること'do
   @user.save
   another_user = FactoryBot.build(:user, email: @user.email)
   another_user.valid?
   expect(another_user.errors.full_messages).to include('Email has already been taken')
   end
   
   it 'ニックネームがないと登録不可' do
    @user.nickname=""
    @user.valid?
    expect(@user.errors.full_messages).to include("Nickname can't be blank")
   end

   

   it 'メールアドレスがないと登録不可' do
    @user.email=""
    @user.valid?
    expect(@user.errors.full_messages).to include("Email can't be blank")
   end
   
   it 'メールアドレスは、@を含まないと登録不可'do
    @user.email='testtest.com'
    @user.valid?
    expect(@user.errors.full_messages).to include("Email is invalid")
   end

   it 'パスワードは、5文字以下で登録不可' do
    @user.password="11111"
    @user.password_confirmation="11111"
    @user.valid?
    expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
   end

   it 'パスワードとパスワード（確認用）は、値の一致しないと登録不可' do
    @user.password="222aaa"
    @user.password_confirmation="222bbb"
    @user.valid?
    expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
   end
   
  it 'ユーザー本名は、名字だけ空欄の場合登録不可' do
    @user.first_name=""
    @user.last_name="太朗"
    @user.valid?
    expect(@user.errors.full_messages).to include("First name can't be blank")
  end

   it 'ユーザー本名は、名前だけ空欄の場合登録不可' do
    @user.first_name="佐藤"
    @user.last_name=""
    @user.valid?
    expect(@user.errors.full_messages).to include("Last name can't be blank")
  end

  it 'ユーザー本名は、漢字・平仮名・カタカナ以外では登録不可' do
    @user.first_name="itoe"
    @user.last_name="12@"
    @user.valid?
    expect(@user.errors.full_messages).to include("First name 全角文字を使用してください", "Last name 全角文字を使用してください")
  end
  
  it 'ユーザー本名のフリガナは、カタカナ以外を使用すると登録不可（名字の場合）' do
    @user.first_furigana="佐藤"
    @user.last_furigana="タロウ"
    @user.valid?
    expect(@user.errors.full_messages).to include("First furigana 全角カタカナを使用してください")
  end

  it 'ユーザー本名のフリガナは、カタカナ以外を使用すると登録不可（名前の場合）' do
    @user.first_furigana="サトウ"
    @user.last_furigana="太郎"
    @user.valid?
    expect(@user.errors.full_messages).to include("Last furigana 全角カタカナを使用してください")
  end
  
   it '生年月日の入力がないと登録不可' do
    @user.birthday=""
    @user.valid?
    expect(@user.errors.full_messages).to include("Birthday can't be blank")
   end

  end

end
