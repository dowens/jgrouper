require 'java'
require 'json'

require_relative 'jgrouper/group'
require_relative 'jgrouper/group_type'
require_relative 'jgrouper/stem'
require_relative 'jgrouper/subject'
require_relative 'jgrouper/version'


#
# = JGrouper - JRuby wrapper around the Internet2 Grouper API
#
# == Usage
#
#   require 'jgrouper'
#
#   # Set path to your Grouper API installation
#   JGrouper.home = '/path/to/your/grouper/api/installation/directory'
#
# === Subjects
#
#   # Find root subject
#   JGrouper::Subject.root do |subject|
#     subject.id     # Subject identifier
#     subject.name   # Subject name
#     subject.source # Subject source identifier
#     subject.type   # Subject type name
#   end
#
# === Stems
#
#   # Find root stem
#   JGrouper::Stem.root do |stem|
#     stem.display_name # Stem display name
#     stem.name         # Stem name
#     stem.uuid         # Stem UUID
#   end
#
#   # Find by name
#   stem = JGrouper::Stem.find(name) { |stem| ... }
#
#   # Create stem(s)
#   stem = JGrouper::Stem.create 'foo:bar:baz', 'Foo:Bar:Baz'
#
#   # Create child stem(s)
#   child = stem.create 'foo:bar:baz'
#
# === Groups
#
#   # Find by name
#   group = JGrouper::Group.find(name) do |group|
#     group.display_name # Group display name
#     group.name         # Group name
#     group.types        # Array of group type names
#     group.uuid         # Group UUID
#   end
#
# === Group Types
#
#   # Create group type
#   JGrouper::GroupType.create(name) do |group_type|
#     group_type.name # Group type name
#     group_type.uuid # Group type uuid
#   end
#
#   # Find all group types
#   group_types = JGrouper::GroupType.all { |group_type| ... }
#
#   # Find group type
#   JGrouper::GroupType.find(name)
#
#   # Delete group type
#   JGrouper::GroupType.delete(name)
#   # ... or ...
#   JGrouper::GroupType.find(name).delete
#
# == Installation
#
# Add this line to your application's Gemfile:
#
#   gem 'jgrouper'
#
# And then execute:
#
#    $ bundle
#
# Or install it yourself as:
#
#    $ gem install jgrouper
#
# == Contributing
#
# 1. Fork it
# 2. Create your feature branch (+git checkout -b my-new-feature+)
# 3. Commit your changes (+git commit -am 'Added some feature'+)
# 4. Push to the branch (+git push origin my-new-feature+)
# 5. Create new Pull Request
#
# == Author
#
# blair christensen. <mailto:blair.christensen@gmail.com>
#
# == Home Page
#
# https://github.com/blairc/jgrouper
#
# == See Also
#
# JGrouper::Shell https://github.com/blairc/jgrouper-shell, JGrouper::Server https://github.com/blairc/jgrouper-server, http://grouper.internet2.edu
#
module JGrouper

  #
  # Initialize Grouper API.
  #
  def self.home(path)
    # TODO This could/should be so much better.
    [ "#{path}/lib/grouper/", "#{path}/lib/jdbcSamples" ].each do |dir|
      Dir[ "#{dir}/*.jar" ].each { |jar| $CLASSPATH << jar } 
    end
    $CLASSPATH << File.join( path, 'conf' )
    $CLASSPATH << File.join( path, 'dist', 'lib', 'grouper.jar' )

    # TODO Can I eliminate these if I refer to everything by full path?
    #      Or maybe something like:
    #        include_class 'java.lang.String' { |package, name| 'JString' }
    #      Test the above w/ GroupType?
    %w( edu.internet2.middleware.subject.SubjectNotFoundException
        edu.internet2.middleware.grouper.GrouperSession
        edu.internet2.middleware.grouper.GroupFinder
        edu.internet2.middleware.grouper.SubjectFinder
        edu.internet2.middleware.grouper.StemFinder
    ).each { |klass| include_class klass }
  end

end

if __FILE__ == $0
  JGrouper.home ENV['GROUPER_HOME']
  puts JGrouper::Group.find('etc:wheel')
end

