class Artifact < ActiveRecord::Base
  has_many :artifact_logs
  has_many :sponsorships
  has_many :users, :through => :sponsorships

  has_many :sponsors, :through => :sponsorships, 
    :conditions => {'sponsorships.confirmed' => true},
    :source => :user
  has_many :potential_sponsors, :through => :sponsorships, 
    :conditions => {'sponsorships.confirmed' => false},
    :source => :user
  
  attr_accessible :solr_document_id

  state_machine :initial => :initiated do
    event :request do;    transition :initiated => :requested; end
    event :withdraw do;   transition :requested => :initiated; end
    event :digitize do;   transition :requested => :digitizing; end
    event :deny do;       transition :requested => :denied; end
    event :available do;  transition :digitizing => :published; end

    before_transition any => any do |artifact, transition|
      raise ArgumentError, "Specify a user" unless transition.args.first
    end

    after_transition any => any do |artifact, transition|
      user = transition.args.first
      ArtifactLog.record(user, artifact, {
        event: transition.event,
        from: transition.from,
        to: transition.to
      })
    end

    after_transition :on => :withdraw do |artifact, transition|
      user = transition.args.first
      artifact.withdraw_user(user)
      Rails.logger.info('WITHDRAWN')
      AdminMailer.request_withdrawn_email(user, artifact).deliver
    end

    after_transition :on => :request do |artifact, transition|
      user = transition.args.first
      artifact.potential_sponsors << user
      Rails.logger.info('REQUESTED')
      AdminMailer.request_notification_email(user, artifact).deliver
    end

    after_transition :on => :digitize do |artifact, transition| 
      user = transition.args.first
      Rails.logger.info('DIGITIZING')
      artifact.users.each do |user| 
        UserMailer.digitization_approval_email(user, artifact).deliver
      end
    end

    after_transition :on => :deny do |artifact, transition| 
      user = transition.args.first
      Rails.logger.info('DENIED')
      artifact.users.each do |user| 
        UserMailer.digitization_denial_email(user, artifact).deliver
      end
    end

    after_transition :on => :published do |artifact, transition| 
      user = transition.args.first
      Rails.logger.info('PUBLISHED')
      # do stuff - means we have metadata, ingested into solr and moved it into media server
    end
  end

  def to_s
    "ID#{id}: SOLR_ID"
  end

  def withdraw_request(user)
    if sponsorships.size == 1
      withdraw!(user)
    else
      withdraw_user(user)
      ArtifactLog.record(user, self, {
        event: 'withdraw',
        from: 'requested',
        to: 'requested',
        description: 'User withdrew sponsorship (sponsors still available)'
      })
    end
  end

  def withdraw_user(user, options={})
    sponsorships.where(:user_id => user).first.delete
  end

  def request_digitization(user)
    if state == 'initiated'
      request!(user)
    else
      potential_sponsors << user
      ArtifactLog.record(user, self, {
        event: 'request',
        from: 'requested',
        to: 'requested',
        description: 'User requested digitization on previously requested artifact'
      })
    end
  end
end