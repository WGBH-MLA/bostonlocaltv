class ApplicationController < ActionController::Base
  # Adds a few additional behaviors into the application controller 
  include Blacklight::Controller
  # Please be sure to impelement current_user and user_session. Blacklight depends on 
  # these methods in order to perform user specific actions. 
  
  layout "old_layout"
  
  protect_from_forgery

  def default_html_head
  end

  # ======================================================================
  private

  def generate_key(secret, salt, iterations=65536, key_size=32)
    OpenSSL::PKCS5.pbkdf2_hmac_sha1(secret, salt, iterations, key_size)
  end

  def secret_key
    generate_key(ENV["LOCAL_SECRET_KEY"], "a pinch for seasoning")
  end

  def set_encrypted_cookie(name, value)
    encryptor = ActiveSupport::MessageEncryptor.new(secret_key)
    cookies[name] = {value: encryptor.encrypt_and_sign(value)}
  end

  def get_encrypted_cookie(name)
    return nil if cookies[name].blank?
    
    begin
      encryptor = ActiveSupport::MessageEncryptor.new(secret_key)
      encryptor.decrypt_and_verify(cookies[name])
    rescue ActiveSupport::MessageEncryptor::InvalidMessage
      nil
    end
  end
  
  helper_method :get_encrypted_cookie # Makes it accessible in views if needed

  # ======================================================================
  protected

  # Overrides Blacklight::Controller#layout_name
  def layout_name
    "old_layout"
  end
end
