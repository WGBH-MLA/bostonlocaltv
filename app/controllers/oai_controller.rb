class OaiController < ApplicationController
  Record = Struct.new(:id, :date, :title, :descriptions, :subjects, :video, :locations, :date_created, :names)
  ROWS = 100

  def index
    @verb = params.delete(:verb)
    fail("Unsupported verb: #{@verb}") unless @verb == 'ListRecords'

    @metadata_prefix = params.delete(:metadataPrefix) || 'mods'
    fail("Unsupported metadataPrefix: #{@metadata_prefix}") unless @metadata_prefix == 'mods'

    resumption_token = params.delete(:resumptionToken) || '0'
    fail("Unsupported resumptionToken: #{resumption_token}") unless resumption_token =~ /^\d*$/
    start = resumption_token.to_i

    unsupported = params.keys - %w(action controller format)
    fail("Unsupported params: #{unsupported}") unless unsupported.empty?

    @response_date = Time.now.strftime('%FT%T')

    @records =
      RSolr.connect(url: 'http://localhost:8983/solr/')
      .get('select', params: {
             'q' => '*:*',
             'fl' => '*',
             'rows' => ROWS,
             'start' => start
           })['response']['docs'].map do |d|
        Record.new(d['id'], d['timestamp'], d['title_s'], d['description_s'], d['subject_s'], d['video_b'], d['location_s'], d['date_created_s'], d['name_s'])
      end

    # Not ideal: they'll need to go past the end.
    @next_resumption_token = start + ROWS unless @records.empty?

    respond_to do |format|
      format.xml do
        render
      end
    end
  end
end
