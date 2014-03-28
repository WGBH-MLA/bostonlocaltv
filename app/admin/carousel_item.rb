ActiveAdmin.register CarouselItem do   
  show do |user|
    attributes_table do
      row :id
      row :title
      row :body
      row :url do |item|
        link_to item.url, item.url
      end
      row :image do |item|
        image_tag item.image
      end
      row :enabled
      row :position
      row :created_at
    end
  end
end
