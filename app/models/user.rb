class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:google_oauth2]

  has_many :sns_credentials
  def self.from_omniauth(auth)
    sns = SnsCredential.where(provider: auth.provider, uid: auth.uid).first_or_create
    user = User.where(email: auth.info.email).first_or_initialize(
      nickname: auth.info.name,
        email: auth.info.email)

        if user.persisted?
          sns.user = user
          sns.save
        end
        { user: user, sns: sns }
  end

  with_options presence: true do
    validates :nickname
    validates :birthday
    validates :first_name, :last_name, format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: '全角文字を使用してください' }
    validates :first_furigana, :last_furigana, format: { with: /\A[ァ-ヶー－]+\z/, message: '全角カタカナを使用してください' }
    validates :password, format: { with: /(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]/, message: '全て半角で英数字を混ぜて設定してください' }
  end

  has_many :items,dependent: :destroy
  has_many :orders
  has_one :card, dependent: :destroy
  has_one :address,foreign_key: 'user_id'

  

  end
