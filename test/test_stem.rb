# encoding: utf-8

require_relative 'helper'


# TODO JGrouper::Stem::TestCase
class TestStem < Test::Unit::TestCase

  def setup
    @json = { 'json_class'   => JGrouper::Stem,
              'display_name' => '',
              'name'         => '',
              'uuid'         => 'some-fake-uuid'
            }.to_json
    @root = OpenStruct.new :getDisplayName => '',
                           :getName        => '',
                           :getUuid        => 'some-fake-uuid'
  end


  def test_mocked_find_root_stem
    Java::EduInternet2MiddlewareGrouper::GrouperSession.expects(:startRootSession).returns true
    Java::EduInternet2MiddlewareGrouper::StemFinder.expects(:findRootStem).returns @root
    JGrouper::Stem.root_stem do |stem|
      assert_not_nil stem
      assert         stem.kind_of? JGrouper::Stem
      assert_equal   '',               stem.display_name
      assert_equal   '',               stem.name
      assert_equal   'some-fake-uuid', stem.uuid
    end
  end

  def test_mocked_stem_to_json
    Java::EduInternet2MiddlewareGrouper::GrouperSession.expects(:startRootSession).returns true
    Java::EduInternet2MiddlewareGrouper::StemFinder.expects(:findRootStem).returns @root
    assert_equal @json, JGrouper::Stem.root_stem.to_json
  end

  def test_stem_from_json
    stem = JSON.parse @json
    assert_not_nil stem
    assert         stem.kind_of? JGrouper::Stem
    assert_equal   '',               stem.display_name
    assert_equal   '',               stem.name
    assert_equal   'some-fake-uuid', stem.uuid
  end

end

