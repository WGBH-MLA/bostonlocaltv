# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :shopping_cart_item do
    title Faker::Lorem.sentence(word_count = 4)
    status ""
    completed false
    shopping_cart_id nil
    solr_document_id nil
  end
end
