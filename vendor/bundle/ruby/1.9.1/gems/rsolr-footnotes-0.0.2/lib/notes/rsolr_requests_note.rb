module Footnotes::Notes
  class RsolrRequestsNote < AbstractNote
    def self.query_subscriber
      @@query_subscriber ||= RsolrSubscriber.new
    end

    def self.start!(controller)
      self.query_subscriber.reset!
    end

    def events
      self.class.query_subscriber.events
    end

    def self.title
      "Solr Requests"
    end

    def stylesheet
      <<-CSS
        .rsolr_response_note { margin-bottom: 1em }
        .rsolr_response_note .response { padding-left: 50px; color: #777; }

      CSS
    end

    def content
      html = ''

      events.each_with_index do |event, index|
        html << <<-HTML
        <div class="rsolr_response_note">
          <b>#{event.method.to_s.upcase} #{event.path}</b> (<a href="#{ event.uri.to_s }">[link]</a>)
          <span>(#{ event.duration } ms)</span><br />
          <span><b>params:</b> #{ event.params.inspect }</span><br />
          <span><b>header:</b> #{ event.response["responseHeader"].inspect }</span><br />
          <a href=\"javascript:Footnotes.toggle('rsolr_response_#{index}')\" style=\"color:#00A;\">toggle response</a>
          <p class="response" id="rsolr_response_#{index}" style="display:none;">#{ event.response.inspect }</p>
        </div>
        HTML
      end

      html
    end
  end

  class RsolrSubscriberNotificationEvent < ActiveSupport::Notifications::Event
    def initialize *args
      super(*args)
    end

    def path
      payload[:path]
    end

    def response
      payload[:response]
    end

    def params
      payload[:params]
    end

    def query
      payload[:query]
    end

    def method
      payload[:method]
    end

    def uri
      payload[:uri]
    end
  end

  class RsolrSubscriber < ActiveSupport::LogSubscriber
    attr_accessor :events

    def initialize
      self.events = []

      ActiveSupport::Notifications.subscribe("execute.rsolr_client") do |*args|
        # args.last[:caller] = caller
        @events << RsolrSubscriberNotificationEvent.new(*args)
      end
    end

    def reset!
      self.events.clear
    end

  end
end
