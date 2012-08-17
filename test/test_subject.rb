# encoding: utf-8

require_relative 'helper'


class JGrouper::Subject::TestCase

  def test_mocked_find_root_subject
    Java::EduInternet2MiddlewareGrouper::SubjectFinder.expects(:findRootSubject).returns grouper_root_subject
    JGrouper::Subject.root do |subject|
      assert_not_nil subject
      assert         subject.kind_of? JGrouper::Subject
      assert_equal   'GrouperSystem',   subject.id 
      assert_equal   'GrouperSysAdmin', subject.name 
      assert_equal   'g:isa',           subject.source 
      assert_equal   'application',     subject.type 
    end
  end

  def test_mocked_subject_to_json
    Java::EduInternet2MiddlewareGrouper::SubjectFinder.expects(:findRootSubject).returns grouper_root_subject
    assert_equal root_subject_as_json, JGrouper::Subject.root.to_json
  end

  def test_subject_from_json
    subject = JSON.parse root_subject_as_json
    assert_not_nil subject
    assert         subject.kind_of? JGrouper::Subject
    assert_equal   'GrouperSystem',   subject.id 
    assert_equal   'GrouperSysAdmin', subject.name 
    assert_equal   'g:isa',           subject.source 
    assert_equal   'application',     subject.type 
  end

end

