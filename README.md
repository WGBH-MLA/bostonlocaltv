# Boston Local TV News Catalog

The Boston Local TV News Catalog is a Blacklight application.

- Ruby on Rails
- Blacklight (a rails engines plugin) for the User Interface
- Solr (a java application, also ported to other languages) for the Search Engine 

## Introduction and Installation Instructions

### Use RVM in development (for your own sanity)

This isn’t absolutely required, but working without RVM makes life really difficult.

See https://rvm.beginrescueend.com/rvm/install/ for instructions on installing and running RVM.

You probably want to use Ruby 1.9.3 with this application.

```sh
$ gem install bundler
```

### Getting the application

```sh
$ git clone git://github.com/WGBH/bostonlocaltv.git
$ cd bostonlocaltv
$ bundle install
$ rake db:migrate
$ rails s
```


## Rake Tasks

These rake tasks are provided by jettywrapper for managing the jetty servlet container:

```
rake jetty:config                              # config
rake jetty:config_solr                         # Copies the contents of solr_conf into the Solr development-core and test-c...
rake jetty:environment                         # Load the jetty config
rake jetty:load                                # Copies the default SOLR config files and starts up the jetty server
rake jetty:restart                             # Restarts jetty
rake jetty:start                               # Start jetty
rake jetty:status                              # Return the status of jetty
rake jetty:stop                                # stop jetty

```      

Also provided are rake tasks for loading data

```
rake data:bpl [file=FILE]                                  # Load BPL data
```

