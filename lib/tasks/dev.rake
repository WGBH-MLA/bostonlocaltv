namespace :dev do

  desc "Run continuous integration tests"
  task :ci => ["db:migrate", "spec"]

end