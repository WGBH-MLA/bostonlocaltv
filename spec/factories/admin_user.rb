FactoryGirl.define do
  factory :admin_user do
    email { "#{Faker::Name.first_name}@#{Faker::Internet.domain_name}".downcase }
    password { Faker::Lorem.characters 8 }
    password_confirmation { "#{password}" }
  end
end
