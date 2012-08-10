# encoding: utf-8

require_relative 'helper'


# TODO JGrouper::GroupType::TestCase
class TestGroupType < Test::Unit::TestCase

  def setup
    @json = { 'json_class' => JGrouper::GroupType,
              'name'       => 'jgrouper',
              'uuid'       => 'some-fake-uuid'
            }.to_json
    @type = OpenStruct.new :getName => 'jgrouper',
                           :getUuid => 'some-fake-uuid'
  end


  def test_mocked_create_group_type
    Java::EduInternet2MiddlewareGrouper::GrouperSession.expects(:startRootSession).returns true
    Java::EduInternet2MiddlewareGrouper::GroupType.expects(:createType).returns @type
    JGrouper::GroupType.create('jgrouper') do |group_type|
      assert_not_nil group_type
      assert         group_type.kind_of? JGrouper::GroupType
      assert_equal   'jgrouper',       group_type.name
      assert_equal   'some-fake-uuid', group_type.uuid
    end
  end

  def test_mocked_group_type_to_json
    Java::EduInternet2MiddlewareGrouper::GrouperSession.expects(:startRootSession).returns true
    Java::EduInternet2MiddlewareGrouper::GroupType.expects(:createType).returns @type
    assert_equal @json, JGrouper::GroupType.create('jgrouper').to_json
  end

  def test_group_type_from_json
    group_type = JSON.parse @json
    assert_not_nil group_type
    assert         group_type.kind_of? JGrouper::GroupType
    assert_equal   'jgrouper',       group_type.name
    assert_equal   'some-fake-uuid', group_type.uuid
  end

  def test_mocked_find_by_name
    Java::EduInternet2MiddlewareGrouper::GroupTypeFinder.expects(:find).returns @type
    JGrouper::GroupType.find('base') do |group_type|
      assert_not_nil  group_type
      assert          group_type.kind_of? JGrouper::GroupType
      assert_equal   'jgrouper',       group_type.name
      assert_equal   'some-fake-uuid', group_type.uuid
    end
  end

  def test_mocked_find_by_name_failure
    Java::EduInternet2MiddlewareGrouper::GroupTypeFinder.expects(:find).returns nil
    assert_nil JGrouper::GroupType.find('jgrouper')
  end

end

