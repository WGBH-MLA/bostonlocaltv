#!/usr/bin/env rake
# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

Bostonlocaltv::Application.load_tasks

desc "Run Travis"
task :ci => ["dev:ci"]

Rake::Task[:default].prerequisites.clear if Rake::Task.task_defined?(:default)
task :default => [:ci]
