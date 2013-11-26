require 'rspec'
require "simplecov"

require_relative "../lib/weather.rb"

SimpleCov.start do
  add_group "Libraries", "lib"
  add_filter "/vendor/"
  add_filter "/spec/"
end
