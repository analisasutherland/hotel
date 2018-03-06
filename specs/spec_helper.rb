require 'simplecov'
SimpleCov.start
require 'minitest'
# require "minitest/pride"
require "minitest/autorun"
require "minitest/reporters"

require_relative '../lib/admin.rb'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new
