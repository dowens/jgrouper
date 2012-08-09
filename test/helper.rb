# encoding: utf-8

# TODO JGrouper::TestCase

require 'test/unit'
require 'mocha'
require 'ostruct'

require_relative '../lib/jgrouper'

require 'simplecov'
SimpleCov.start

raise RuntimeError, "ENV[GROUPER_HOME'] must be set!" unless ENV['GROUPER_HOME']
JGrouper.home ENV['GROUPER_HOME']

