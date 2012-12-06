require 'helper'

class TestRsolrFootnotes < Test::Unit::TestCase
  def setup
    @mock_controller = mock()
    RsolrFootnotes.setup_rsolr_notifications!

    Footnotes::Notes::RsolrRequestsNote.start!(@mock_controller)

    @note = Footnotes::Notes::RsolrRequestsNote.new(@mock_controller)
    @mock_connection = mock()
    @mock_connection.expects(:execute).returns({:body => '{}', :headers => nil, :status => 200})

    @solr = RSolr.connect :url => 'http://solrserver.example.com'
    @solr.expects(:connection).returns(@mock_connection)

  end

  should "add notifications to rsolr" do
    @solr.head("admin/ping")
    assert_equal 1, @note.events.length
    assert_equal "admin/ping", @note.events.first.path
  end
end
