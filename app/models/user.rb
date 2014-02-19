class User < ActiveRecord::Base
  # Connects this user object to Blacklights Bookmarks and Folders. 
 include Blacklight::User
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # has_many :shopping_carts
  has_many :user_items
  

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name
  
  validates_presence_of :email, :on => :create, :message => "can't be blank"
  validates_presence_of :password, :on => :create, :message => "can't be blank"
  validates_presence_of :password_confirmation, :on => :create, :message => "can't be blank"
  validates_presence_of :first_name, :on => :create, :message => "can't be blank"
  validates_presence_of :last_name, :on => :create, :message => "can't be blank"

  def full_name
    "#{self.first_name} #{self.last_name}"
  end
  
  def cart_items_count(user)
    cart = ShoppingCart.user_open_cart(user).last
    if cart
      count = cart.shopping_cart_items.length
      count 
    else
      "0"
    end
  end

  # Method added by Blacklight; Blacklight uses #to_s on your
  # user class to get a user-displayable login/identifier for
  # the account. 
  def to_s
    email
  end
end
