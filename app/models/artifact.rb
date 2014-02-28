class Artifact < ActiveRecord::Base
  has_many :artifact_subscriptions
  has_many :artifact_logs
  has_many :users, :through => :artifact_subscriptions
  has_many :sponsorships
  has_many :sponsors, :through => :sponsorships, :source => :user

  has_many :potential_sponsors, :through => :artifact_logs, 
    :conditions => {'artifact_logs.event' => 'request'}, 
    :source => :user, :uniq => true
  
  attr_accessible :solr_document_id

  state_machine :initial => :initiated do
    event :request do;    transition :initiated => :requested; end
    event :withdraw do;   transition :requested => :initiated; end
    event :digitize do;   transition :requested => :digitizing; end
    event :deny do;       transition :requested => :denied; end
    event :available do;  transition :digitizing => :published; end

    after_transition any => any do |artifact, transition|
      raise ArgumentError, "Specify a user" unless transition.args.first
      user = transition.args.first

      ArtifactLog.record(user, artifact, {
        event: transition.event,
        from: transition.from,
        to: transition.to
      })
    end

    after_transition :on => :withdraw do |artifact, transition|
      raise ArgumentError, "Specify a user" unless transition.args.first
      user = transition.args.first
      # artifact.users << user
      Rails.logger.info('WITHDRAWN')
      # AdminMailer.request_notification_email(user, artifact).deliver
    end

    after_transition :on => :request do |artifact, transition|
      raise ArgumentError, "Specify a user" unless transition.args.first
      user = transition.args.first
      artifact.users << user
      Rails.logger.info('REQUESTED')
      AdminMailer.request_notification_email(user, artifact).deliver
    end

    after_transition :on => :digitize do |artifact, transition| 
      Rails.logger.info('DIGITIZING')
      artifact.users.each do |user| 
        UserMailer.digitization_approval_email(user, artifact).deliver
      end
    end

    after_transition :on => :deny do |artifact, transition| 
      Rails.logger.info('DENIED')
      artifact.users.each do |user| 
        UserMailer.digitization_denial_email(user, artifact).deliver
      end
    end

    after_transition :on => :published do |artifact, transition| 
      Rails.logger.info('PUBLISHED')
      # do stuff - means we have metadata, ingested into solr and moved it into media server
    end
  end

  def to_s
    "ID#{id}: artifact information - TBD"
  end

  def withdraw_request(user)
    # if more than 1 user left, log withdrawal, remove them from potential sponsors
    # if they're the only sponsor, trigger artifact withdrawal, move back to 'initiated'
  end

  def request_digitization(user)
    if state == 'initiated'
      request!(user)
    else
      users << user
      ArtifactLog.record(user, self, {
        event: 'request',
        from: 'requested',
        to: 'requested'
      })
    end
  end
end
