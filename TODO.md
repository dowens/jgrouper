JGrouper To Do
==============

JGrouper v0.0.4
---------------
* Add *JGrouper::Group#types*
* Add *JGrouper::Group#add_type*
* Add *JGrouper::Stem#children( recurse = false )*
* Add *JGrouper::Stem#groups( recurse = false )*
* Add *JGrouper::Stem#stems( recurse = false )*


Future
------
* Add *JGrouper::Stem#add_group( name, display_name = nil )*
* Add *JGrouper::Group.create( name, display_name = nil )*
* Add *JGrouper::Group#members*
* Add *JGrouper::Group#add_member(?)*
* Add *JGrouper::Stem#delete( recurse = false )*
* Add *JGrouper::Stem.delete( name, recurse = false )*
* Add *JGrouper::Stem.find(uuid)*
* Add *JGrouper::Stem.exists?(name)*
* Add *JGrouper::Group.exists?(name)*
* Add *JGrouper::Stem#root?(name)*
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

