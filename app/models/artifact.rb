class Artifact < ActiveRecord::Base

  has_many :users, :through => :user_artifacts
  has_many :user_artifacts
  
  attr_accessible :solr_document_id

  state_machine :initial => :archived do
    event :request do;    transition :archived => :requested; end
    event :approve do;    transition :requested => :approved; end
    event :deny do;       transition :requested => :denied; end
    event :digitize do;   transition :approved => :digitizing; end
    event :available do;  transition :digitizing => :available; end

    after_transition :on => :request do |artifact, transition| 
      Rails.logger.info('REQUESTED')
      # do stuff
    end

    after_transition :on => :approve do |artifact, transition| 
      Rails.logger.info('APPROVE')
      # do stuff
    end

    after_transition :on => :deny do |artifact, transition| 
      Rails.logger.info('DENIED')
      # do stuff
    end

    after_transition :on => :digitize do |artifact, transition| 
      Rails.logger.info('DIGITIZING')
      # do stuff
    end

    after_transition :on => :available do |artifact, transition| 
      Rails.logger.info('AVAILABLE')
      # do stuff
    end
  end
end
