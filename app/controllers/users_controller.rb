class UsersController < ApplicationController
  def show
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    card = Card.find_by(user_id: current_user.id)

    redirect_to new_card_path and return unless card.present?
 
    customer = Payjp::Customer.retrieve(card.customer_token) # 先程のカード情報を元に、顧客情報を取得
    @card = customer.cards.first

  end

  def update
    @user = User.find(params[:id])
    if current_user.update(user_params) # 更新出来たかを条件分岐する
       sign_in(current_user, bypass: true)
      redirect_to root_path # 更新できたらrootパスへ
    else
      redirect_to "/users/#{current_user.id}" # 失敗すれば再度マイページへ
    end
  end

  private

  def user_params
    params.require(:user).permit(:password,:nickname, :email,:first_name, :last_name, :first_furigana, :last_furigana, :birthday) # 編集出来る情報を制限
  end
end
