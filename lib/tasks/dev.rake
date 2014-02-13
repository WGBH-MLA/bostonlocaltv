namespace :dev do

  desc "Run continuous integration tests"
  task :ci => ["jetty:load", "db:migrate", "spec"]

end