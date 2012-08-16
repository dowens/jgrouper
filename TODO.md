JGrouper To Do
==============

JGrouper v0.0.3
---------------
* Add *JGrouper::GroupType.delete(name)*
* Add *JGrouper::Stem.create( name, create_parents = true )*
* Add *JGrouper::Stem#create( name, create_parents = true )*
* Add *JGrouper::Stem.find(name)*
* Add *JGrouper::Stem.find(uuid)*
* Add *JGrouper::Stem#delete( recurse = false )*
* Add *JGrouper::Stem.delete( name, recurse = false )*


Future
------
* Add *JGrouper::Group*
* Add *JGrouper::Group.find(name)*
* Implement *JGrouper::Subject.sources* (using *edu.internet2.middleware.subject.provider.SourceManager*)
* Implement *JGrouper::Subject.source(id)* (using *edu.internet2.middleware.subject.provider.SourceManager*)
* Implement *JGrouper::Subject::Source#to_json* (for "jgrouper-server")
* Add child stem
* Get child stems
* Delete child stem
* Add child group
* Get child groups
* Delete child group
* Add group member
* Get group members
* Remove group member
* Grant stem privileges
* Get stem privileges
* Revoke stem privileges
* Grant group privileges
* Get group privileges
* Revoke group privileges
* Add privilege to stem and all children
* Add privilege to all groups beneath a stem
* JGrouper::TestCase
* JGrouper::Subject::TestCase
* JGrouper::Subject::TestCase
* Make *JGrouper::Shell* startup less chatty
* Extract *JGrouper::Shell* to own gem?
* Add *gsh* compatibility commands to *JGrouper::Shell*?
* Should *JGrouper::Shell* be able to run scripts?

