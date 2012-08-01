require 'jgrouper/version'
require 'java'


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
        edu.internet2.middleware.grouper.GrouperSession
        edu.internet2.middleware.grouper.SubjectFinder
        edu.internet2.middleware.grouper.StemFinder
    ).each { |klass| include_class klass }
  end

end


# TODO DRY w/ ::Subject
class JGrouper::Stem

  def initialize(stem)
    @stem = stem
    yield self if block_given?
    self
  end

  def self.root_stem
    stem = self.new StemFinder.findRootStem( GrouperSession.startRootSession ) # XXX How to handle sessions?
    yield stem if block_given?
    stem
  end

  def to_s
    %w( name display_name uuid ).collect { |k| "#{k}=#{ self.send(k) }" }.join(' | ') 
  end

  def uuid;         @stem.getUuid;        end
  def name;         @stem.getName;        end
  def display_name; @stem.getDisplayName; end
end


# TODO DRY w/ ::Stem
class JGrouper::Subject

  def initialize(subject)
    @subject = subject
    yield self if block_given?
    self
  end

  def self.root_subject
    subj = self.new SubjectFinder.findRootSubject
    yield subj if block_given?
    subj
  end

  def to_s
    %w( id name type source ).collect { |k| "#{k}=#{ self.send(k) }" }.join(' | ')
  end

  def id;     @subject.getId;    end
  def name;   @subject.getName;  end
  def source; @subject.sourceId; end
  def type;   @subject.typeName; end

end


if __FILE__ == $0
  JGrouper.home ENV['GROUPER_HOME'] if ENV['GROUPER_HOME']
  JGrouper::Subject.root_subject { |subject| puts "root_subject => #{subject}" }
  JGrouper::Stem.root_stem       { |stem| puts "root_stem => #{stem}" }
end

