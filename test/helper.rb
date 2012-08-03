# encoding: utf-8

# TODO JGrouper::TestCase

require_relative '../lib/jgrouper'

require 'test/unit'
require 'mocha'

require 'simplecov'
SimpleCov.start

raise RuntimeError, "ENV[GROUPER_HOME'] must be set!" unless ENV['GROUPER_HOME']
JGrouper.home ENV['GROUPER_HOME']

