module ArtifactsHelper
	def artifact_digitization_link(document, artifact)
    return nil if published_artifact?(artifact)
    return nil if document.has? "video_s"
    return unable_to_digitize if blocked_artifact?(artifact)
    return authenticated_digitization_link(document, artifact) if current_user
    unauthenticated_digitization_link
  end

  def authenticated_digitization_link(document, artifact)
    return already_requested if currently_requested?(document, artifact)
    return track_artifact_link(document) if requested_by_someone_else?(document, artifact) && artifact.digitizing?
    return request_digitization_link(document) if !blocked_artifact?(artifact)
    return 
  end

  def unauthenticated_digitization_link
    login = link_to 'log in', new_user_session_path, :class => "btn btn-mini btn-primary"
    signup = link_to 'sign up', new_user_registration_path, :class => "btn btn-mini btn-primary"
    "Please #{login} or #{signup} to request this item".html_safe
  end

  def requested_by_someone_else?(document, artifact)
    artifact && !currently_requested?(document, artifact)
  end

  def currently_requested?(document, artifact)
    current_user.requested_artifact?(document.id)
  end

  def already_requested
    dashboard_link = link_to 'view request' , dashboard_path, :class => "label label-info"
    "You have requested this item, #{dashboard_link}".html_safe
  end

  def blocked_artifact?(artifact)
    artifact && artifact.state == "blocked"
  end

  def published_artifact?(artifact)
    artifact && artifact.state == "published"
  end

  def unable_to_digitize
    "<span class='label label-inverse'>We are unable to digitize this item.</span>".html_safe
  end

  def track_artifact_link(document)
   track = link_to "Track this item", digitizations_path(:id => document.id), method: "POST", :class => "btn btn-mini btn-primary" 
   "Currently in the digitization process... #{track}".html_safe
  end

  def request_digitization_link(document)
    link_to "Request digitization of this item", digitizations_path(:id => document.id), method: "POST", :class => "btn btn-mini btn-primary"
  end

end
