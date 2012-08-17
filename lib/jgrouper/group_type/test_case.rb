# encoding: utf-8

require 'test/unit'
require 'factory_girl'


module JGrouper #: :nodoc:
  #
  # = JGrouper::GroupType::TestCase - For testing JGrouper::GroupType
  #
  class GroupType::TestCase < Test::Unit::TestCase

    def grouper_type
      FactoryBuild :jgrouper_grouper_tyype
    end

    def jgrouper_type_as_json
      FactoryGirl.attributes_for(:jgrouper_type).to_json
    end

  end
end

