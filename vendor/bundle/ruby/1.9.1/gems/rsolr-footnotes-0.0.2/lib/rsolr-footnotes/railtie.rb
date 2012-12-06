require 'rsolr-footnotes'
require 'rails'

module RsolrFootnotes
  class Railtie < Rails::Railtie
    RsolrFootnotes.load!
    Footnotes::Filter.notes += [:rsolr_requests]
  end
end
