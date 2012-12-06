require 'helper'

class TestRsolrNotifications < Test::Unit::TestCase
  should "add notifications to rsolr" do
    RsolrFootnotes.setup_rsolr_notifications!

    @events = []
    ActiveSupport::Notifications.subscribe("execute.rsolr_client") do |*args|
      @events <<  ActiveSupport::Notifications::Event.new(*args)
    end

    solr = RSolr.connect :url => 'http://solrserver.example.com'

    @mock_connection = mock()
    @mock_connection.expects(:execute).returns({:body => '{}', :headers => nil, :status => 200})
    solr.expects(:connection).returns(@mock_connection)

    solr.head("admin/ping")

    assert_equal 1, @events.length
    assert_equal({}, @events.first.payload[:response])

  end
end
