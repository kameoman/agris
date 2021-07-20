FactoryBot.define do
  factory :customer do
    name {Faker::Name.last_name}
    email {Faker::Internet.free_email}
    password = Faker::Internet.password(min_length: 6)
    password {password}
    password_confirmation {password}
    phone_number { "08011112222" }
    address {"東京都千代田区1－1"}
    kana {"ヤマダ"}
  end
end