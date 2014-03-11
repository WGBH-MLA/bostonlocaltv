module SponsorshipsHelper
  def sponsorship_status(sponsorship)
    return "Following" if sponsorship.status == "Requested"
    sponsorship.status
  end

  def sponsorship_actions(sponsorship)
    return if sponsorship.status == "Confirmed/Sponsor"
    link_to "Unfollow", digitization_path(sponsorship.artifact.id), method: "DELETE"
  end
end

