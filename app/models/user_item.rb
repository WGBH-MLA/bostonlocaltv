class UserItem < ActiveRecord::Base
  attr_accessible :solr_document_id, :user_id, :user, :status

  belongs_to :user

  validates_presence_of :user

  has_many :digitization_actions
end