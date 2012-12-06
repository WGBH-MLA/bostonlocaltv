require 'rsolr'
require 'rails-footnotes'
require 'rails-footnotes/footnotes'
require 'rails-footnotes/abstract_note'
require 'active_support/notifications'

module RsolrFootnotes
  # Load the plugin and footnote pane
  def self.load!
    Dir[File.join(File.dirname(__FILE__), 'notes', '*.rb')].each { |note| require note }
    self.setup_rsolr_notifications!
  end

  # Inject notifications into RSolr
  def self.setup_rsolr_notifications!
    require 'rsolr-ext/notifications'

    RSolr::Client.send(:include, RSolr::Ext::Notifications)
    RSolr::Client.enable_notifications!
  end

  require File.join(File.dirname(__FILE__), 'rsolr-footnotes', 'railtie') if defined?(Rails)

end
