# encoding: utf-8

require_relative 'helper'


class JGrouper::Stem::TestCase

  def test_mocked_find_root_stem
    Java::EduInternet2MiddlewareGrouper::GrouperSession.expects(:startRootSession).returns true
    Java::EduInternet2MiddlewareGrouper::StemFinder.expects(:findRootStem).returns grouper_root_stem

    JGrouper::Stem.root do |stem|
      assert_not_nil stem
      assert         stem.kind_of? JGrouper::Stem
      assert_equal   '',               stem.display_name
      assert_equal   '',               stem.name
      assert_equal   'some-fake-uuid', stem.uuid
    end
  end

  def test_mocked_stem_to_json
    Java::EduInternet2MiddlewareGrouper::GrouperSession.expects(:startRootSession).returns true
    Java::EduInternet2MiddlewareGrouper::StemFinder.expects(:findRootStem).returns grouper_root_stem

    assert_equal root_stem_as_json, JGrouper::Stem.root.to_json
  end

  def test_stem_from_json
    stem = JSON.parse root_stem_as_json
    assert_not_nil stem
    assert         stem.kind_of? JGrouper::Stem
    assert_equal   '',               stem.display_name
    assert_equal   '',               stem.name
    assert_equal   'some-fake-uuid', stem.uuid
  end

  def test_mocked_find_by_name
    Java::EduInternet2MiddlewareGrouper::GrouperSession.expects(:startRootSession).returns true
    Java::EduInternet2MiddlewareGrouper::StemFinder.expects(:findByName).returns grouper_stem('foo:bar')

    JGrouper::Stem.find('foo:bar') do |stem|
      assert_not_nil stem
      assert         stem.kind_of? JGrouper::Stem
      assert_equal   'foo',      stem.display_name
      assert_equal   'foo',      stem.name
      assert_equal   'stem-foo', stem.uuid
    end
  end

  def test_mocked_find_by_name_failure
    Java::EduInternet2MiddlewareGrouper::GrouperSession.expects(:startRootSession).returns true
    Java::EduInternet2MiddlewareGrouper::StemFinder.expects(:findByName).returns nil

    assert_nil JGrouper::Stem.find('foo:bar')
  end

  def test_mocked_create_stem_without_display_name_and_without_intermediaries
    root_stem = grouper_root_stem

    JGrouper::Stem.expects(:root).returns root_stem
    root_stem.expects(:add_stem).returns JGrouper::Stem.send( :from_grouper, grouper_stem(:foo) )

    JGrouper::Stem.create('foo') do |stem|
      assert_not_nil  stem
      assert          stem.kind_of? JGrouper::Stem
      assert_equal    'foo',  stem.display_name
      assert_equal    'foo',  stem.name
      assert_not_nil  stem.uuid
    end 
  end

  def test_mocked_create_stem_with_display_name_and_with_intermediaries
    root_stem = grouper_root_stem
    stem_foo  = grouper_stem :foo

    JGrouper::Stem.expects(:root).returns root_stem
    root_stem.expects(:add_stem).returns stem
    stem.expects(:add_stem).returns JGrouper::Stem.send( :from_grouper, grouper_stem('foo:bar') )

    JGrouper::Stem.create('foo:bar', 'foo:Bar') do |stem|
      assert_not_nil  stem
      assert          stem.kind_of? JGrouper::Stem
      assert_equal    'foo:Bar',  stem.display_name
      assert_equal    'foo:bar',  stem.name
      assert_not_nil  stem.uuid
    end 
  end

end

