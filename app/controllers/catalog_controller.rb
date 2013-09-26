# -*- encoding : utf-8 -*-
require 'blacklight/catalog'

class CatalogController < ApplicationController  

  include Blacklight::Catalog

  configure_blacklight do |config|
    config.default_solr_params = { 
      :qt => 'search',
      :per_page => 10 
    }

    # solr field configuration for search results/index views
    config.index.show_link = 'title_s' 
    config.index.record_display_type = 'collection_s'
 

    # solr field configuration for document/show views
    config.show.html_title = 'title_s' 
    config.show.heading = 'title_s'
    config.show.display_type = 'collection_s'

    # solr fields that will be treated as facets by the blacklight application
    #   The ordering of the field names is the order of the display
    #
    # Setting a limit will trigger Blacklight's 'more' facet values link.
    # * If left unset, then all facet values returned by solr will be displayed.
    # * If set to an integer, then "f.somefield.facet.limit" will be added to
    # solr request, with actual solr request being +1 your configured limit --
    # you configure the number of items you actually want _displayed_ in a page.    
    # * If set to 'true', then no additional parameters will be sent to solr,
    # but any 'sniffed' request limit parameters will be used for paging, with
    # paging at requested limit -1. Can sniff from facet.limit or 
    # f.specific_field.facet.limit solr request params. This 'true' config
    # can be used if you set limits in :default_solr_params, or as defaults
    # on the solr side in the request handler itself. Request handler defaults
    # sniffing requires solr requests to be made with "echoParams=all", for
    # app code to actually have it echo'd back to see it.  
    config.add_facet_field 'collection_s', :label => 'Collection'
    #config.add_facet_field 'subject_facet_s', :label => 'Subject', :limit => 5
    #config.add_facet_field 'people_s', :label => 'People', :limit => 5
    config.add_facet_field 'location_facet_s', :label => 'Places', :limit => 5
    config.add_facet_field 'year_i', :label => 'Date', :range => true
    config.add_facet_field 'video_s', :label => 'Video Available'

    # Have BL send all facet field names to Solr, which has been the default
    # previously. Simply remove these lines if you'd rather use Solr request
    # handler defaults, or have no facets.
    config.default_solr_params[:'facet.field'] = config.facet_fields.keys

    # solr fields to be displayed in the index (search results) view
    #   The ordering of the field names is the order of the display 
    config.add_index_field 'description_s', :label => 'Description' 
    config.add_index_field 'date_created_s', :label => 'Date Created'
    config.add_index_field 'date_estimated_s', :label => 'Date Estimated'
    config.add_index_field 'collection_s', :label => 'Collection', :link => true
    


    # solr fields to be displayed in the show (single result) view
    #   The ordering of the field names is the order of the display 
    config.add_show_field 'program_s', :label => 'Program Type'
    config.add_show_field 'date_created_s', :label => 'Date Created', :custom => '(estimated)'
    config.add_show_field 'date_estimated_s', :label => 'Date Estimated'
    config.add_show_field 'id', :label => 'ID number'
    config.add_show_field 'description_s', :label => 'Description' 
    config.add_show_field 'subject_s', :label => 'Subjects', :link => true
    config.add_show_field 'location_s', :label => 'Locations', :link => true
    config.add_show_field 'related_s', :label => 'Related Records'
    config.add_show_field 'format', :label => 'Physical format'
    config.add_show_field 'audio_type_s', :label => 'Audio Type'
    config.add_show_field 'audio_format_s', :label => 'Audio Format'
    config.add_show_field 'audio_duration_s', :label => 'Duration'
    config.add_show_field 'format_color_s', :label => 'Color'
    config.add_show_field 'broadcast_date_s', :label => 'Date Broadcast'
    config.add_show_field 'collection_s', :label => 'Collection', :link => true
    config.add_show_field 'h_location_s', :label => 'Holding Institution', :link => true
    config.add_show_field 'p_location_s', :label => 'Physical Location'
    config.add_show_field 'footage_length_s', :label => 'Footage Length' 
    config.add_show_field 'credit_s', :label => 'Credit'
    config.add_show_field 'contributor_name_role_s', :label => 'Contributor' 
    config.add_show_field 'subject_personalities_s', :label => 'Personalities:'
    config.add_show_field 'intended_purpose_s', :label => 'Type or Purpose'
    config.add_show_field 'can_number_s', :label => 'Can Number:', :link => true
    config.add_show_field 'format_location_s', :label => 'Location'
    config.add_show_field 'cross_reference_s', :label => 'Cross Reference'
    config.add_show_field 'accession_num_s', :label => 'Accession Number'
    config.add_show_field 'language_s', :label => 'Language'

    # "fielded" search configuration. Used by pulldown among other places.
    # For supported keys in hash, see rdoc for Blacklight::SearchFields
    #
    # Search fields will inherit the :qt solr request handler from
    # config[:default_solr_parameters], OR can specify a different one
    # with a :qt key/value. Below examples inherit, except for subject
    # that specifies the same :qt as default for our own internal
    # testing purposes.
    #
    # The :key is what will be used to identify this BL search field internally,
    # as well as in URLs -- so changing it after deployment may break bookmarked
    # urls.  A display label will be automatically calculated from the :key,
    # or can be specified manually to be different. 

    # This one uses all the defaults set by the solr request handler. Which
    # solr request handler? The one set in config[:default_solr_parameters][:qt],
    # since we aren't specifying it otherwise. 
    
    config.add_search_field 'all_fields', :label => 'All Fields'
    

    # Now we see how to over-ride Solr request handler defaults, in this
    # case for a BL "search field", which is really a dismax aggregate
    # of Solr search fields. 
    
    config.add_search_field('title') do |field|
      # solr_parameters hash are sent to Solr as ordinary url query params. 
      field.solr_parameters = { :'spellcheck.dictionary' => 'title' }

      # :solr_local_parameters will be sent using Solr LocalParams
      # syntax, as eg {! qf=$title_qf }. This is neccesary to use
      # Solr parameter de-referencing like $title_qf.
      # See: http://wiki.apache.org/solr/LocalParams
      field.solr_local_parameters = { 
        :qf => 'title_t',
        :pf => 'title_t'
      }
    end
    
    config.add_search_field('contributor') do |field|
      field.solr_parameters = { :'spellcheck.dictionary' => 'author' }
      field.solr_local_parameters = { 
        :qf => 'contributor_name_t',
        :pf => 'contributor_name_t'
      }
    end
    
    # "sort results by" select (pulldown)
    # label in pulldown is followed by the name of the SOLR field to sort by and
    # whether the sort is ascending or descending (it must be asc or desc
    # except in the relevancy case).
    config.add_sort_field 'score desc, title_sort asc, id asc', :label => 'relevance'
    config.add_sort_field 'title_sort asc, id asc', :label => 'title'
    config.add_sort_field 'year_i asc, date_s asc, title_sort asc', :label => 'year'

    # If there are more than this many search results, no spelling ("did you 
    # mean") suggestion is offered.
    config.spell_max = 5
  end

    def citation
     #doc_id = get_doc_id (params[:docid])
     @response, @document = get_solr_response_for_doc_id (params[:docid])
     respond_to do |format|
     format.html 
     end
   end

     def get_doc_id (id)
        id.bytes.to_s
     end

end 
