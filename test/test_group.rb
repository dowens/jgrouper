# encoding: utf-8

require_relative 'helper'


class JGrouper::Group::TestCase

  def test_mocked_find_wheel
    Java::EduInternet2MiddlewareGrouper::GrouperSession.expects(:startRootSession).returns true
    Java::EduInternet2MiddlewareGrouper::GroupFinder.expects(:findByName).returns grouper_wheel_group

    JGrouper::Group.find('etc:wheel') do |group|
      assert_not_nil group
      assert         group.kind_of? JGrouper::Group
      assert_equal   '',               group.display_name
      assert_equal   '',               group.name
      assert_equal   [ 'base' ],       group.types
      assert_equal   'some-fake-uuid', group.uuid
    end
  end

  def test_mocked_group_to_json
    Java::EduInternet2MiddlewareGrouper::GrouperSession.expects(:startRootSession).returns true
    Java::EduInternet2MiddlewareGrouper::GroupFinder.expects(:findByName).returns grouper_wheel_group

    assert_equal wheel_group_as_json, JGrouper::Group.find('etc:wheel').to_json
  end

  def test_group_from_json
    group = JSON.parse wheel_group_as_json
    assert_not_nil group
    assert         group.kind_of? JGrouper::Group
    assert_equal   'Etc:Wheel',       group.display_name
    assert_equal   'etc:wheel',       group.name
    assert_equal   [ 'base' ],        group.types
    assert_equal   'etc-wheel-group', group.uuid
  end

end

