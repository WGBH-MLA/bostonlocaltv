class ShoppingCartItem < ActiveRecord::Base
  #include Blacklight::Catalog
  belongs_to :shopping_cart
  
  #validates_presence_of :shopping_cart, :on => :create, :message => "can't be blank"
  validates_presence_of :solr_document_id, :on => :create, :message => "can't be blank"
  
  attr_accessible :shopping_cart_id, :solr_document_id
  
  def solr_doc
    #@response, @document = get_solr_response_for_doc_id (self.solr_document_id)
    ''
  end
  
end
