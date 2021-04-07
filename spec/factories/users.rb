FactoryBot.define do
  factory :user do
    nickname {Faker::Name.last_name}
    email {Faker::Internet.free_email}
    password = Faker::Internet.password(min_length: 6)
    password {password}
    password_confirmation {password}
    first_name {"名字"}
    last_name {"名前"}
    first_furigana {"ミョウジ"}
    last_furigana {"ナマエ"}
    birthday   {"2021-01-01"}
  end
end