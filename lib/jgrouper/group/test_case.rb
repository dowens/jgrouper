# encoding: utf-8

require 'test/unit'
require 'factory_girl'


module JGrouper # :nodoc:
  #
  # = JGrouper::Group::TestCase - For testing JGrouper::Group
  #
  class Group::TestCase < Test::Unit::TestCase

    def grouper_wheel_group
      FactoryGirl.build :grouper_wheel_group
    end

    def wheel_group_as_json
      FactoryGirl.attributes_for(:wheel_group).to_json
    end

  end
end

