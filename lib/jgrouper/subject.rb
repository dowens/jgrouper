module JGrouper #: :nodoc:
  #
  # = JGrouper::Subject - A Grouper subject.
  #
  class Subject

    attr_accessor :id, :name, :source, :type

    def initialize
      @grouper_subject = nil
      yield self if block_given?
      self
    end

    #
    # Generate JGrouper::Subject instance from JSON by calling +JSON.parse(json_string)+
    # 
    def self.json_create(json)
      new do |subject|
        subject.id     = json['id']
        subject.name   = json['name']
        subject.source = json['source']
        subject.type   = json['type']
      end
    end

    #
    # Return root subject.
    #
    #   root_subject = JGrouper::Subject.root_subject
    #
    def self.root_subject
      subject = from_grouper SubjectFinder.findRootSubject
      yield subject if block_given?
      subject
    end

    #
    # Return JSON representation of JGrouper::Subject instance.
    #
    def to_json
      { 
        :json_class => self.class.name,
        :id         => self.id,
        :name       => self.name,
        :source     => self.source,
        :type       => self.type
      }.to_json
    end

    #
    # Return String representation of JGrouper::Subject instance.
    #
    def to_s
      %w( id name type source ).collect { |k| "#{k}=#{ self.send(k) }" }.join(' | ')
    end


    private

    def self.from_grouper(grouper)
      new do |subject|
        subject.instance_variable_set :@grouper_subject, grouper # XXX Is this even needed?

        subject.id     = grouper.getId
        subject.name   = grouper.getName
        subject.source = grouper.sourceId
        subject.type   = grouper.typeName
      end
    end

  end
end

