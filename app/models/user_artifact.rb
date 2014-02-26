class UserArtifact < ActiveRecord::Base
	belongs_to :user
	belongs_to :artifacts
end