class ShoppingCart < ActiveRecord::Base
  belongs_to :user
  has_many :shopping_cart_items, :dependent => :destroy
    
  scope :has_items, lambda { |user|
        joins(:shopping_cart_items)
        .where('shopping_carts.user_id = ?', user.id)
        .select('shopping_carts.id, shopping_carts.status, shopping_carts.updated_at')
        .group('shopping_carts.id')
        .having('count(shopping_cart_items.id) > 0')
        .order('shopping_carts.updated_at DESC')
      }
  
  scope :user_open_cart, lambda { |user| 
    where('shopping_carts.status = ? AND shopping_carts.user_id = ?', 'open', user.id)
  }
  
  scope :open, where(status: 'open')
  scope :pending, where(status: 'submitted')
  scope :closed, where(status: 'closed')
    
  accepts_nested_attributes_for :shopping_cart_items
  
  validates_presence_of :user_id, :on => :create, :message => "can't be blank"
  
  def submit_date
    self.updated_at.to_formatted_s(:long)
  end
  
  def has_items?
    if self.shopping_cart_items.length > 0
      true
    else
      false
    end
  end
    
end
