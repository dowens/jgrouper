# encoding: utf-8

require_relative 'helper'
require 'ostruct'


# TODO JGrouper::Subject::TestCase
class TestSubject < Test::Unit::TestCase

  def setup
    @root = OpenStruct.new :getId    => 'GrouperSystem',
                           :getName  => 'GrouperSysAdmin',
                           :sourceId => 'g:isa',
                           :typeName => 'application'
  end


  def test_mocked_find_root_subject
    Java::EduInternet2MiddlewareGrouper.SubjectFinder.expects(:findRootSubject).returns @root
    JGrouper::Subject.root_subject do |root|
      assert_not_nil root
      assert         root.kind_of? JGrouper::Subject
      assert_equal   'GrouperSystem',   root.id 
      assert_equal   'GrouperSysAdmin', root.name 
      assert_equal   'g:isa',           root.source 
      assert_equal   'application',     root.type 
    end
  end

end

