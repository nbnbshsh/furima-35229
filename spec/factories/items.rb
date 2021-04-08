FactoryBot.define do
  factory :item do
    item_name             {"名前"}
    explain               {"asefasdf"}
    category_id           {2}
    condition_id          {2}
    delivery_fee_id       {2}
    prefecture_id         {2}
    delivery_date_id      {2}
    price                 {10000}

    association :user

    after(:build) do |message|
      message.image.attach(io: File.open('public/images/sample1.png'), filename: 'sample1.png')
    end

  end
end