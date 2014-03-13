class User < ActiveRecord::Base
  # Connects this user object to Blacklights Bookmarks and Folders. 
 include Blacklight::User
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :artifact_logs
  has_many :sponsorships
  has_many :artifacts, :through => :sponsorships

  has_many :sponsored_artifacts, :through => :sponsorships, 
    :conditions => {'sponsorships.confirmed' => true},
    :source => :artifact
  
  has_many :potentially_sponsored_artifacts, :through => :sponsorships, 
    :conditions => {'sponsorships.confirmed' => false},
    :source => :artifact


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

  def requested_artifact?(solr_document_id)
    !!artifacts.find_by_solr_document_id(solr_document_id)
  end

  # Method added by Blacklight; Blacklight uses #to_s on your
  # user class to get a user-displayable login/identifier for
  # the account. 
  def to_s
    "#{full_name} (#{email})"
  end
end
