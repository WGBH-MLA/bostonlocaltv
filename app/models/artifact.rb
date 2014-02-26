class Artifact < ActiveRecord::Base
  
  attr_accessible :solr_document_id

  state_machine :initial => :archived do
    event :request do;    transition :archived => :requested; end
    event :approve do;    transition :requested => :approved; end
    event :deny do;       transition :requested => :denied; end
    event :digitize do;   transition :approved => :digitizing; end
    event :available do;  transition :digitizing => :available; end

    after_transition :on => :request do |media, transition| 
      Rails.logger.info('REQUESTED')
      # do stuff
    end

    after_transition :on => :approve do |media, transition| 
      Rails.logger.info('APPROVE')
      # do stuff
    end

    after_transition :on => :deny do |media, transition| 
      Rails.logger.info('DENIED')
      # do stuff
    end

    after_transition :on => :digitize do |media, transition| 
      Rails.logger.info('DIGITIZING')
      # do stuff
    end

    after_transition :on => :available do |media, transition| 
      Rails.logger.info('AVAILABLE')
      # do stuff
    end
  end
end
