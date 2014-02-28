class ArtifactLog < ActiveRecord::Base
  belongs_to :artifact
  belongs_to :user

  def self.record(user, artifact, options={})
    create(
      :user => user, 
      :artifact => artifact, 
      :event => options[:event], 
      :from => options[:from], 
      :to => options[:to],
      :description => options[:description]
    )
  end
end
