# encoding: utf-8

require 'test/unit'
require 'factory_girl'


module JGrouper #: :nodoc:
  #
  # = JGrouper::Subject::TestCase - For testing JGrouper::Subject
  #
  class Subject::TestCase < Test::Unit::TestCase

    def grouper_root_subject
      FactoryGirl.build :grouper_root_subject
    end

    def root_subject_as_json
      FactoryGirl.attributes_for(:root_subject).to_json
    end

  end
end

