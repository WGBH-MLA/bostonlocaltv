namespace :data do
  desc "Load BPL data"
  task :bpl => :environment do
    file = ENV['file']
    Dataset::Bpl.new(file).process!
  end

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

  desc "Load PB Core data"
  task :pb_core => :environment do
      file = ENV['file']
      Dataset::Pb_core.new(file).process!
  end

  desc "Load NHF data"
  task :nhf => :environment do
    file = ENV['file']
    Dataset::Nhf.new(file).process!
  end

  task :nhf_assignment_sheets => :environment do
    file = ENV['file']
    Dataset::NhfAssignmentSheets.new(file).process!
  end

end
