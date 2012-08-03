# encoding: utf-8

require_relative 'helper'
require 'ostruct'


# TODO JGrouper::Stem::TestCase
class TestStem < Test::Unit::TestCase

  def setup
    @root = OpenStruct.new :getDisplayName => '',
                           :getName        => '',
                           :getUuid        => 'some-fake-uuid'
  end


  def test_mocked_find_root_stem
    Java::EduInternet2MiddlewareGrouper.GrouperSession.expects(:startRootSession).returns true
    Java::EduInternet2MiddlewareGrouper.StemFinder.expects(:findRootStem).returns @root
    JGrouper::Stem.root_stem do |root|
      assert_not_nil root
      assert         root.kind_of? JGrouper::Stem
      assert_equal   '',               root.display_name
      assert_equal   '',               root.name
      assert_equal   'some-fake-uuid', root.uuid
    end
  end

end

