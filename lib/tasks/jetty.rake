namespace :jetty do

  desc "Unpack a clean version of blacklight-jetty"
  task :clean do
    Jettywrapper.url = "https://github.com/projectblacklight/blacklight-jetty/archive/v4.6.0.zip"
    Jettywrapper.clean
  end

  desc "Copy our solr configuration into the jetty instance"
  task :config => :environment do
    FileList["solr_conf/conf/*"].each do |f|  
      cp("#{f}", "jetty/solr/blacklight-core/conf/", :verbose => true)
    end
  end

  desc "Starts up a new solr instance with our configuration"
  task :load => [:stop, :clean, :config, :start]

end
