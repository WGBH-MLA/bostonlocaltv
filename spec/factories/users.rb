# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    # the fake user has arbitrary name, email, and passowrd.
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { "#{first_name}_#{last_name}@#{Faker::Internet.domain_name}".downcase }
    
    # NOTE: The user that is created by this factory will NOT have a password nor password_confirmation
    # for attr_accessors. When the 
    password { Faker::Lorem.characters 8 }
    password_confirmation { "#{password}" }
  end
end
