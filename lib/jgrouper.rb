require 'jgrouper/version'
require 'java'

#
# TODO Find Root Stem
# TODO Document
# TODO Release v0.0.1
# TODO Basic stem operations
# TODO Release v0.0.2
# TODO Basic group operations
# TODO Release v0.0.3
# TODO Tests!
#

class JGrouper

  def self.home(path); self.new path; end

  private

  # XXX Better, please.
  def initialize(path)
    [ "#{path}/lib/grouper/", "#{path}/lib/jdbcSamples" ].each do |dir|
      Dir[ "#{dir}/*.jar" ].each { |jar| $CLASSPATH << jar } 
    end
    $CLASSPATH << File.join( path, 'conf' )
    $CLASSPATH << File.join( path, 'dist', 'lib', 'grouper.jar' )

    %w( edu.internet2.middleware.subject.SubjectNotFoundException
        edu.internet2.middleware.grouper.SubjectFinder
    ).each { |klass| include_class klass }
  end

end

class JGrouper::Subject

  def initialize(subject)
    @subject = subject
    yield self if block_given?
    self
  end

  def self.root_subject
    s = self.new SubjectFinder.findRootSubject
    yield s if block_given?
    s
  end

  def to_s
    "id=%s | type=%s | name=%s | source=%s" % [ id, name, type, source ]
  end

  def id;     @subject.getId;    end
  def name;   @subject.getName;  end
  def source; @subject.sourceId; end
  def type;   @subject.typeName; end

end


if __FILE__ == $0
  JGrouper.home ENV['GROUPER_HOME'] if ENV['GROUPER_HOME']
  JGrouper::Subject.root_subject { |subject| puts "root_subject => #{subject}" }
end

