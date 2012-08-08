
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
    # Generate stem instance from JSON by calling +JSON.parse(json_string)+
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
    #   root_stem = JGrouper::Stem.root_stem
    #
    def self.root_stem
      stem = from_grouper_stem StemFinder.findRootStem( GrouperSession.startRootSession ) # XXX How to handle sessions?
      yield stem if block_given?
      stem
    end

    #
    # Return JSON representation of stem.
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
    # Return string representation of stem.
    #
    def to_s
      %w( name display_name uuid ).collect { |k| "#{k}=#{ self.send(k) }" }.join(' | ') 
    end


    private

    def self.from_grouper_stem(grouper_stem)
      new do |stem|
        stem.instance_variable_set :@grouper_stem, grouper_stem # XXX Is this even needed?

        stem.display_name = grouper_stem.getDisplayName
        stem.name         = grouper_stem.getName
        stem.uuid         = grouper_stem.getUuid
      end
    end

  end
end

