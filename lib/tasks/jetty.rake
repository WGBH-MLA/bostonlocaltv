namespace :jetty do

  desc "config"
  task :config => :environment do
    Rake::Task["jetty:config_solr"].invoke
  end

  desc "Copies the contents of solr_conf into the Solr development-core and test-core of Testing Server" 
  task :config_solr do
    FileList['solr_conf/*'].each do |f|  
      cp_r("#{f}", 'jetty/solr/development-core/', :verbose => true)
      cp_r("#{f}", 'jetty/solr/test-core/', :verbose => true)
      cp_r("#{f}", 'jetty/solr/production-core/', :verbose => true)
    end
  end

  desc "Copies the default SOLR config files and starts up the jetty server"
  task :load => [:config, :start]

end
