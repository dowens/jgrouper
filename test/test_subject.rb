# encoding: utf-8

require_relative 'helper'
require 'ostruct'


# TODO JGrouper::Subject::TestCase
class TestSubject < Test::Unit::TestCase

  def setup
    @json = { 'json_class' => JGrouper::Subject,
              'id'         => 'GrouperSystem',
              'name'       => 'GrouperSysAdmin',
              'source'     => 'g:isa',
              'type'       => 'application'
            }.to_json
    @root = OpenStruct.new :getId    => 'GrouperSystem',
                           :getName  => 'GrouperSysAdmin',
                           :sourceId => 'g:isa',
                           :typeName => 'application'
  end


  def test_mocked_find_root_subject
    Java::EduInternet2MiddlewareGrouper.SubjectFinder.expects(:findRootSubject).returns @root
    JGrouper::Subject.root_subject do |subject|
      assert_not_nil subject
      assert         subject.kind_of? JGrouper::Subject
      assert_equal   'GrouperSystem',   subject.id 
      assert_equal   'GrouperSysAdmin', subject.name 
      assert_equal   'g:isa',           subject.source 
      assert_equal   'application',     subject.type 
    end
  end

  def test_mocked_subject_to_json
    Java::EduInternet2MiddlewareGrouper.SubjectFinder.expects(:findRootSubject).returns @root
    assert_equal @json, JGrouper::Subject.root_subject.to_json
  end

  def test_subject_from_json
    subject = JSON.parse @json
    assert_not_nil subject
    assert         subject.kind_of? JGrouper::Subject
    assert_equal   'GrouperSystem',   subject.id 
    assert_equal   'GrouperSysAdmin', subject.name 
    assert_equal   'g:isa',           subject.source 
    assert_equal   'application',     subject.type 
  end

end

