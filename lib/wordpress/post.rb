module Wordpress
  class Post
    def self.find id
      parsed_json = ActiveSupport::JSON.decode(open(self.endpoint_uri(id)).read)
      raise "Missing Wordpress Post #{ self.endpoint_uri(id)}" unless parsed_json["status"] == "ok"
      Post.new(parsed_json)
    end

    def self.endpoint_uri id
      "#{Wordpress.endpoint}/#{id}?json=1&custom_fields=collection-links,funders,related-links"
    end

    attr_accessor :post

    def initialize json
      @json = json
      self.post = json["post"]
    end

    def title
      self.post["title"]
    end

    def url
      self.post["url"]
    end

    def date
      DateTime.parse(self.post["date"])
    end

    def author_name
      self.post["author"]["name"]
    end

    def author_slug
      self.post["author"]["slug"]
    end

    def custom_fields
      self.post["custom_fields"]
    end

    def thumbnail 
      self.post["thumbnail"]
    end

    def attachments
      self.post["attachments"]
    end

    def images type
      @images ||= self.attachments.reject{ |x| x["images"].nil? }.first.try(:[], 'images')
      @images[type]
    end

    def excerpt
      self.post["excerpt"] || self.content
    end

    def content
      self.post["content"]
    end

    def custom_fields
      self.post["custom_fields"]
    end
  end
end
