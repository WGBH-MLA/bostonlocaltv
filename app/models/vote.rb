class Vote < ActiveRecord::Base
  self.primary_key = "id"
  belongs_to :item, :counter_cache => true
end
