class Artifact < ActiveRecord::Base
  has_many :artifact_subscriptions
  has_many :users, :through => :artifact_subscriptions
  
  attr_accessible :solr_document_id

  state_machine :initial => :archived do
    event :request do;    transition :archived => :requested; end
    event :approve do;    transition :requested => :approved; end
    event :deny do;       transition :requested => :denied; end
    event :digitize do;   transition :approved => :digitizing; end
    event :available do;  transition :digitizing => :available; end

    after_transition :on => :request do |artifact, transition|
      raise ArgumentError, "Specify a user" unless transition.args.first
      user = transition.args.first
      artifact.users << user
      Rails.logger.info('REQUESTED')
      AdminMailer.request_notification_email(user, artifact).deliver
    end

    after_transition :on => :approve do |artifact, transition| 
      Rails.logger.info('APPROVE')
      artifact.users.each do |user| 
        UserMailer.digitization_approval_email(user, artifact).deliver
      end
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

  def to_s
    "ID#{id}: artifact information - TBD"
  end

  def request_digitization(user)
    if state == 'archived'
      request!(user)
    else
      users << user
    end
  end

end
