class ArtifactSubscription < ActiveRecord::Base
	belongs_to :user
	belongs_to :artifact
end