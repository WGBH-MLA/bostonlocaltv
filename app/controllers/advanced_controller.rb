class AdvancedController < BlacklightAdvancedSearch::AdvancedController

  blacklight_config.configure do |config|
    # name of Solr request handler, leave unset to use the same one as your Blacklight.config[:default_qt]
    config.advanced_search.qt = 'search'

    ##
    # The advanced search form displays facets as a limit option.
    # By default it will use whatever facets, if any, are returned
    # by the Solr qt request handler in use. However, you can use
    # this config option to have it request other facet params than
    # default in the Solr request handler, in desired.
    config.advanced_search.form_solr_parameters = {}

    # name of key in Blacklight URL, no reason to change usually.
    config.advanced_search.url_key = 'advanced'

  end
  
end
