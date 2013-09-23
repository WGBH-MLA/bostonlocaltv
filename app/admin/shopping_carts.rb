ActiveAdmin.register ShoppingCart, :as => 'Request' do
  menu :label => 'Requests', :priority => 1
  config.clear_action_items!
  
  scope :pending, default: true
  scope :closed
  #config.filters = false
  filter :user
  
  index :title => 'Recent Requests' do
    column :id
    column :user
    column :status
    column "Requested records", :shopping_cart_items do |item|
      item.shopping_cart_items.length
    end
    actions :defaults => false do |post|
      if post.status != 'closed'
        link_to "Manage request", admin_request_path(post), :class => "member_link"
      else
        link_to "View", admin_request_path(post), :class => "member_link"
      end
    end
    #default_actions
  end
  
  show do |item|
    if item.status == 'closed'
      render "cart_order_closed"
    else
      render "cart_order"
    end
  end
  
end
