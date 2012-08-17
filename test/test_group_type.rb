# encoding: utf-8

require_relative 'helper'


class JGrouper::GroupType::TestCase

  def test_mocked_create_group_type
    Java::EduInternet2MiddlewareGrouper::GrouperSession.expects(:startRootSession).returns true
    Java::EduInternet2MiddlewareGrouper::GroupType.expects(:createType).returns grouper_type
    JGrouper::GroupType.create('jgrouper') do |group_type|
      assert_not_nil group_type
      assert         group_type.kind_of? JGrouper::GroupType
      assert_equal   'jgrouper',       group_type.name
      assert_equal   'some-fake-uuid', group_type.uuid
    end
  end

  def test_mocked_group_type_to_json
    Java::EduInternet2MiddlewareGrouper::GrouperSession.expects(:startRootSession).returns true
    Java::EduInternet2MiddlewareGrouper::GroupType.expects(:createType).returns grouper_type
    assert_equal jgrouper_type_as_json, JGrouper::GroupType.create('jgrouper').to_json
  end

  def test_group_type_from_json
    group_type = JSON.parse jgrouper_type_as_json
    assert_not_nil group_type
    assert         group_type.kind_of? JGrouper::GroupType
    assert_equal   'jgrouper',       group_type.name
    assert_equal   'some-fake-uuid', group_type.uuid
  end

  def test_mocked_find_all
    Java::EduInternet2MiddlewareGrouper::GroupTypeFinder.expects(:findAll).returns [ grouper_type ]
    group_types = JGrouper::GroupType.all do |group_type|
      assert_not_nil group_type
      assert         group_type.kind_of? JGrouper::GroupType
      assert_equal   'jgrouper',       group_type.name
      assert_equal   'some-fake-uuid', group_type.uuid
    end
    assert_not_nil group_types
    assert_not_nil group_types.first
    assert         group_types.first.kind_of? JGrouper::GroupType
    assert_equal   'jgrouper',       group_types.first.name
    assert_equal   'some-fake-uuid', group_types.first.uuid
  end

  def test_mocked_find_by_name
    Java::EduInternet2MiddlewareGrouper::GroupTypeFinder.expects(:find).returns grouper_type
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

  def test_mocked_instance_delete
    type = grouper_type

    Java::EduInternet2MiddlewareGrouper::GrouperSession.expects(:startRootSession).returns true
    Java::EduInternet2MiddlewareGrouper::GroupTypeFinder.expects(:find).returns type
    type.expects(:delete).returns(nil)

    assert JGrouper::GroupType.find('jgrouper').delete
  end

  def test_mocked_instance_delete_failure
    type = grouper_type

    Java::EduInternet2MiddlewareGrouper::GrouperSession.expects(:startRootSession).returns true
    Java::EduInternet2MiddlewareGrouper::GroupTypeFinder.expects(:find).returns type
    type.expects(:delete).raises(Exception, 'Mocked Exception')

    group_type = JGrouper::GroupType.find('jgrouper')
    assert_equal false,              group_type.delete
    assert_equal 'Mocked Exception', group_type.error.to_s
  end

  def test_mocked_class_delete
    type = grouper_type

    Java::EduInternet2MiddlewareGrouper::GrouperSession.expects(:startRootSession).returns true
    Java::EduInternet2MiddlewareGrouper::GroupTypeFinder.expects(:find).returns type
    type.expects(:delete).returns(nil)

    assert JGrouper::GroupType.delete('jgrouper')
  end

  def test_mocked_class_delete_failure
    type = grouper_type

    Java::EduInternet2MiddlewareGrouper::GrouperSession.expects(:startRootSession).returns true
    Java::EduInternet2MiddlewareGrouper::GroupTypeFinder.expects(:find).returns type
    type.expects(:delete).raises(Exception, 'Mocked Exception')

    assert_equal false, JGrouper::GroupType.delete('jgrouper')
  end

end

