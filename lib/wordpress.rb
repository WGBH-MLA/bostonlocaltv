module Wordpress
  autoload :Post, 'wordpress/post'
  autoload :Page, 'wordpress/page'

  require 'open-uri'

  class Api
    cattr_accessor :endpoint
  end

  def self.endpoint
    Wordpress::Api.endpoint
  end

  def self.get_recent_posts(options = {})
      parsed_json = ActiveSupport::JSON.decode(open(self.endpoint_uri("get_recent_posts", options)).read)
      parsed_json['posts'].map { |x| Post.new('post' => x) }
  end

  def self.endpoint_uri command, options = {}
    options[:json] = command
    "#{Wordpress.endpoint}?#{options.to_param}"
  end
end
