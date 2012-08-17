# encoding: utf-8

require 'test/unit'
require 'factory_girl'


module JGrouper #: :nodoc:
  #
  # = JGrouper::Stem::TestCase - For testing JGrouper::Stem
  #
  class Stem::TestCase < Test::Unit::TestCase

    def grouper_root_stem
      FactoryGirl.build :grouper_root_stem
    end

    def grouper_stem(name)
      case name.to_sym
      when :foo
        FactoryGirl.build :grouper_stem_foo
      when :"foo:bar"
        FactoryGirl.build :grouper_stem_foo_bar
      end
      raise ArgumentError, "invalid name: #{name}"
    end

    def root_stem_as_json
      FactoryGirl.attributes_for(:root_stem).to_json
    end

  end
end

