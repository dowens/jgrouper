module JGrouper #: :nodoc:
  #
  # = JGrouper::Subject - A Grouper subject.
  #
  class Subject

    def initialize(subject)
      @subject = subject
      yield self if block_given?
      self
    end

    #
    # Return root subject.
    #
    #   root_subject = JGrouper::Subject.root_subject
    #
    def self.root_subject
      subj = self.new SubjectFinder.findRootSubject
      yield subj if block_given?
      subj
    end

    def to_s
      %w( id name type source ).collect { |k| "#{k}=#{ self.send(k) }" }.join(' | ')
    end

    #
    # Subject identifier getter.
    #
    def id; @subject.getId; end
    #
    # Subject name getter.
    #
    def name; @subject.getName; end
    #
    # Subject source identifier getter.
    #
    def source; @subject.sourceId; end
    #
    # Subject type name getter.
    #
    def type; @subject.typeName; end

  end
end

