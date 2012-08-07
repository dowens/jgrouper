JGrouper To Do
==============

JGrouper v0.0.2
---------------
* Implement `JGrouper::Subject#to_json` (for/from "jgrouper-server")
* Implement `JGrouper::Stem#to_json` (for/from "jgrouper-server")
* Implement `JGrouper::Subject.sources` (using `edu.internet2.middleware.subject.provider.SourceManager`)
* Implement `JGrouper::Subject.source(id)` (using `edu.internet2.middleware.subject.provider.SourceManager`)
* Implement `JGrouper::Subject::Source#to_json` (for "jgrouper-server")


JGrouper v0.0.3
---------------
* Add child stem
* Get child stems
* Delete child stem
* Update `JGrouper::Stem#to_json` as appropriate
* Release v0.0.3


JGrouper v0.0.4
---------------
* Add child group
* Get child groups
* Delete child group
* Update `JGrouper::Group#to_json` as appropriate
* Release v0.0.4


JGrouper v0.0.5
---------------
* Add group member
* Get group members
* Remove group member
* Update `JGrouper::Group#to_json` as appropriate
* Release v0.0.5


JGrouper v0.0.6
---------------
* Grant stem privileges
* Get stem privileges
* Revoke stem privileges
* Update `JGrouper::Stem#to_json` as appropriate
* Release v0.0.6


JGrouper v0.0.7
---------------
* Grant group privileges
* Get group privileges
* Revoke group privileges
* Update `JGrouper::Group#to_json` as appropriate
* Release v0.0.7


Future
------
* Create command line executable (and remove embedded code from `lib/jgrouper.rb`)
* Add privilege to stem and all children
* Add privilege to all groups beneath a stem
* JGrouper::TestCase
* JGrouper::Subject::TestCase
* JGrouper::Subject::TestCase

