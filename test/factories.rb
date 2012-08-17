# encoding: utf-8

require 'factory_girl'


FactoryGirl.define do
  # Group Types
  factory :jgrouper_type, class: OpenStruct do
    json_class JGrouper::GroupType
    name       'jgrouper'
    uuid       'some-fake-uuid'
  end

  factory :jgrouper_grouper_type, class: OpenStruct do
    getName 'jgrouper'
    getUuid 'some-fake-uuid'
  end

  # Subjects
  factory :grouper_root_subject, class: OpenStruct do
    getId    'GrouperSystem'
    getName  'GrouperSysAdmin'
    sourceId 'g:isa'
    typeName 'application' 
  end

  factory :root_subject, class: OpenStruct do
    json_class JGrouper::Subject
    id         'GrouperSystem'
    name       'GrouperSysAdmin'
    source     'g:isa'
    type       'application'
  end

end

