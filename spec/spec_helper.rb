# -- coding: utf-8

require "rubygems"
require "bundler"
require "active_record"
Bundler.require :default, :test, :development
require "rspec-expectations"
require "rspec/matchers/built_in/be"

if ENV["COVERAGE"]
  require "simplecov"
  SimpleCov.start
end

require File.expand_path("../../lib/source_ids.rb", __FILE__)

ActiveRecord::Base.establish_connection({
  :adapter => 'sqlite3',
  :database => ':memory:',
})

ActiveRecord::Schema.define do
  create_table "users", :force => true do |t|
    t.column "name",  :text
    t.column "email", :text
  end
  create_table "groups", :force => true do |t|
    t.column "name",  :text
  end
  create_table "user_groups", :force => true do |t|
    t.column "user_id", :integer, :null => false
    t.column "group_id", :integer, :null => false
  end
end

require "./spec/support/user_group.rb" # load at first
Dir["./spec/support/**/*.rb"].each{|file| require file }

RSpec.configure do |config|
end
