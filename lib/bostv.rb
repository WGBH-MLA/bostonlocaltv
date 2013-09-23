require 'blacklight'

module Bostv
  class << self
    def add_media_urls solr_doc_ids, opts={}


      log = Logger.new(STDOUT)
      log.level = Logger::INFO

      summary = {
        :attempted => 0,
        :failed => 0,
        :staged => 0
      }

      log.info("Attempting to add media urls to #{solr_doc_ids.count} Solr documents.")
      log.info("NOTE: This script must finish running before any updates are committed to the Solr index.")

      solr_doc_ids = Array.wrap(solr_doc_ids)
      solr_doc_ids.each do |solr_doc_id|

        summary[:attempted] += 1

        begin

          solr_docs = Blacklight.solr.find({:q => "id:#{solr_doc_id}"})['response']['docs']

          if solr_docs.count == 0
            summary[:failed] += 1
            log.info("FAIL: Could not find Solr document with id=\"#{solr_doc_id}\"")
            next
          end

          solr_doc = solr_docs.first

          media_urls = {
            "video_s" => "http://mlamedia01.wgbh.org/videos/#{solr_doc_id}.mp4",
            "image_s" => "http://mlamedia01.wgbh.org/images/#{solr_doc_id}_thumbnail.jpeg"
          }

          solr_doc.merge! media_urls
          Blacklight.solr.add solr_doc
          summary [:staged] += 1
          log.info("STAGED: Media urls added to Solr document with id=\"#{solr_doc_id}\", ready for commit.")
        rescue => e
          summary[:failed] += 1
          log.info("FAIL: Solr id=\"#{solr_doc_id}\". Error: #{e.message}.")
        end
      end
      log.info("\n\n#{summary[:attempted]} attempted, #{summary[:staged]} staged for commit, #{summary[:failed]} failed.")

      if summary[:staged] > 0
        log.info("Committing #{summary[:staged]} documents to Solr index.")
        Blacklight.solr.commit
      else
        log.info("Nothing to commit to Solr index.")
      end

      log.info("Done.")
    end
  end
end