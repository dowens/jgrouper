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
    @root      = OpenStruct.new :getDisplayName => '',
                                :getName        => '',
                                :getUuid        => 'some-fake-uuid'
    @stem      = OpenStruct.new :getDisplayName => 'foo',
                                :getName        => 'foo',
                                :getUuid        => 'stem-foo'
    @grandstem = OpenStruct.new :getDisplayName => 'foo:Bar',
                                :getName        => 'foo:bar',
                                :getUuid        => 'stem-foo-bar'
  end


  def test_mocked_find_root_stem
    Java::EduInternet2MiddlewareGrouper::GrouperSession.expects(:startRootSession).returns true
    Java::EduInternet2MiddlewareGrouper::StemFinder.expects(:findRootStem).returns @root

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
    Java::EduInternet2MiddlewareGrouper::StemFinder.expects(:findRootStem).returns @root

    assert_equal @json, JGrouper::Stem.root.to_json
  end

  def test_stem_from_json
    stem = JSON.parse @json
    assert_not_nil stem
    assert         stem.kind_of? JGrouper::Stem
    assert_equal   '',               stem.display_name
    assert_equal   '',               stem.name
    assert_equal   'some-fake-uuid', stem.uuid
  end

  def test_mocked_find_by_name
    Java::EduInternet2MiddlewareGrouper::GrouperSession.expects(:startRootSession).returns true
    Java::EduInternet2MiddlewareGrouper::StemFinder.expects(:findByName).returns @stem

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
    JGrouper::Stem.expects(:root).returns @root
    @root.expects(:add_stem).returns JGrouper::Stem.send(:from_grouper, @stem)

    JGrouper::Stem.create('foo') do |stem|
      assert_not_nil  stem
      assert          stem.kind_of? JGrouper::Stem
      assert_equal    'foo',  stem.display_name
      assert_equal    'foo',  stem.name
      assert_not_nil  stem.uuid
    end 
  end

  def test_mocked_create_stem_with_display_name_and_with_intermediaries
    JGrouper::Stem.expects(:root).returns @root
    @root.expects(:add_stem).returns @stem
    @stem.expects(:add_stem).returns JGrouper::Stem.send(:from_grouper, @grandstem)

    JGrouper::Stem.create('foo:bar', 'foo:Bar') do |stem|
      assert_not_nil  stem
      assert          stem.kind_of? JGrouper::Stem
      assert_equal    'foo:Bar',  stem.display_name
      assert_equal    'foo:bar',  stem.name
      assert_not_nil  stem.uuid
    end 
  end

end

