require 'java'
require 'jgrouper/stem'
require 'jgrouper/subject'
require 'jgrouper/version'


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
#   # Find root subject
#   JGrouper::Subject.root_subject do |subject|
#     subject.id     # Subject identifier
#     subject.name   # Subject name
#     subject.source # Subject source identifier
#     subject.type   # Subject type name
#   end
#
#   # Find root stem
#   JGrouper::Stem.root_stem do |stem|
#     stem.display_name # Stem display name
#     stem.name         # Stem name
#     stem.uuid         # Stem UUID
#   end
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
# https://github.com/blairc/jgrouper-server, http://grouper.internet2.edu
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

    %w( edu.internet2.middleware.subject.SubjectNotFoundException
        edu.internet2.middleware.grouper.GrouperSession
        edu.internet2.middleware.grouper.SubjectFinder
        edu.internet2.middleware.grouper.StemFinder
    ).each { |klass| include_class klass }
  end

end


# XXX Extract! Remove! Whatever!
if __FILE__ == $0
  JGrouper.home ENV['GROUPER_HOME'] if ENV['GROUPER_HOME']
  JGrouper::Subject.root_subject { |subject| puts "root_subject => #{subject}" }
  JGrouper::Stem.root_stem       { |stem| puts "root_stem => #{stem}" }
end

