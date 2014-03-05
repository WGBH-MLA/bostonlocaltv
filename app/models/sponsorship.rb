class Sponsorship < ActiveRecord::Base
  belongs_to :artifact
  belongs_to :user

  def status
    confirmed? ? 'Confirmed/Sponsor' : 'Requested'
  end
end
