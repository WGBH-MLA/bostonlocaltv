class CarouselItem < ActiveRecord::Base
  mount_uploader :image, CarouselImageUploader
  scope :carousel, order(position: 'ASC').limit(4)
end
