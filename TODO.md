JGrouper To Do
==============

JGrouper v0.0.2
---------------
* Implement *JGrouper::GroupType.find* (using *edu.internet2.middleware.grouper.GroupTypeFinder.findAll()*)
* Implement *JGrouper::GroupType#delete* (using *edu.internet2.middleware.grouper.GroupType#delete(GrouperSession)*)


JGrouper v0.0.3
---------------
* Implement *JGrouper::Subject.sources* (using *edu.internet2.middleware.subject.provider.SourceManager*)
* Implement *JGrouper::Subject.source(id)* (using *edu.internet2.middleware.subject.provider.SourceManager*)
* Implement *JGrouper::Subject::Source#to_json* (for "jgrouper-server")


JJGrouper v0.0.4
---------------
* Add child stem
* Get child stems
* Delete child stem
* Update *JGrouper::Stem#to_json* as appropriate


JGrouper v0.0.5
---------------
* Add child group
* Get child groups
* Delete child group
* Update *JGrouper::Group#to_json* as appropriate


JGrouper v0.0.6
---------------
* Add group member
* Get group members
* Remove group member
* Update *JGrouper::Group#to_json* as appropriate


JGrouper v0.0.7
---------------
* Grant stem privileges
* Get stem privileges
* Revoke stem privileges
* Update *JGrouper::Stem#to_json* as appropriate


JGrouper v0.0.8
---------------
* Grant group privileges
* Get group privileges
* Revoke group privileges
* Update *JGrouper::Group#to_json* as appropriate


Future
------
* Create command line executable (and remove embedded code from *lib/jgrouper.rb*)
* Add privilege to stem and all children
* Add privilege to all groups beneath a stem
* JGrouper::TestCase
* JGrouper::Subject::TestCase
* JGrouper::Subject::TestCase

# vim: syntax=markdown textwidth=0

