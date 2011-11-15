namespace :data do
  desc "Load BPL data"
  task :bpl => :environment do
    file = ENV['file']
    Dataset::Bpl.new(file).process!
  end

  task :nhf => :environment do
    file = ENV['file']
    Dataset::Nhf.new(file).process!
  end

  task :nhf_assignment_sheets => :environment do
    file = ENV['file']
    Dataset::NhfAssignmentSheets.new(file).process!
  end

end
