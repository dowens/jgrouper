module JGrouper # :nodoc:
  #
  # = JGrouper::Stem - A Grouper stem
  #
  class Stem

    attr_accessor :display_name, :name, :uuid

    def initialize
      @grouper_stem = nil
      yield self if block_given?
      self
    end

    #
    # Generate JGrouper::Stem instance from JSON by calling +JSON.parse(json_string)+
    # 
    def self.json_create(json)
      new do |stem|
        stem.display_name = json['display_name']
        stem.name         = json['name']
        stem.uuid         = json['uuid']
      end
    end

    #
    # Return root stem.
    #
    #   root_stem = JGrouper::Stem.root
    #
    def self.root
      stem = from_grouper StemFinder.findRootStem( GrouperSession.startRootSession ) # XXX How to handle sessions?
      yield stem if block_given?
      stem
    end

    #
    # Return JSON representation of JGrouper::Stem instance.
    #
    def to_json
      {
        :json_class   => self.class.name,
        :display_name => self.display_name,
        :name         => self.name,
        :uuid         => self.uuid
      }.to_json
    end

    #
    # Return String representation of JGrouper::Stem instance.
    #
    def to_s
      %w( name display_name uuid ).collect { |k| "#{k}=#{ self.send(k) }" }.join(' | ') 
    end


    private

    def self.from_grouper(grouper)
      new do |stem|
        stem.instance_variable_set :@grouper_stem, grouper # XXX Is this even needed?

        stem.display_name = grouper.getDisplayName
        stem.name         = grouper.getName
        stem.uuid         = grouper.getUuid
      end
    end

  end
end

