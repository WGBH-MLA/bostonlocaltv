# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :dig_action do
    user_item
    admin_user
    type DigAction::TYPES.sample
  end
end
