namespace :data do
  desc "Load WHDH data"
  task :whdh => :environment do
     file = ENV['file']
     Dataset::Whdh.new(file).process!
  end
  
  desc "Load WGBH data"
  task :wgbh => :environment do
      file = ENV['file']
      Dataset::Wgbh.new(file).process!
  end

  desc "Load WCVB data"
  task :wcvb => :environment do
      file = ENV['file']
      Dataset::Wcvb.new(file).process!
  end
  
  desc "Load CCTV data"
  task :cctv => :environment do
      file = ENV['file']
      Dataset::Cctv.new(file).process!
  end
end
