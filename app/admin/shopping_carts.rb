ActiveAdmin.register ShoppingCart do
  menu :label => 'Requests', :priority => 1
  config.clear_action_items!
  scope :pending, default: true
  scope :closed
  #config.filters = false
  filter :user
  
  index do
    column :id
    column :user
    column :status
    column "Requested records", :shopping_cart_items do |item|
      item.shopping_cart_items.length
    end
    actions :defaults => false do |post|
      link_to "Manage request", admin_shopping_cart_path(post), :class => "member_link"
    end
    #default_actions
  end
  
  show do
    render "cart_order"
  end
  
end
