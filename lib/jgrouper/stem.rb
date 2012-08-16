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
    # Create child stem (along with missing intermediaries).
    #
    #   # Create child stem 'foo'
    #   child = stem.add_stem 'foo'
    #
    #   # Create child stem 'foo' with display name of 'Foo'
    #   child = stem.add_stem 'foo', 'Foo'
    #
    #   # Create child stem 'foo:bar:baz' along with any missing intermediaries
    #   child = stem.add_stem 'foo:bar:baz'
    #
    #
    def add_stem( name, display_name = nil )
      # TODO What if names.size != display_names.size?
      names         = name.split ':'
      display_names = display_name.nil? ? names.clone.split : display_name.split(':')

      name, display_name = names.shift, display_names.shift

      child = JGrouper::Stem.find self.name.empty? ? name : [ self.name, name ].join(':') # TODO Yuck
      child = JGrouper::Stem.from_grouper @grouper_stem.addChildStem(name, display_name) if child.nil?

      # TODO What if child can't be created?
      child = child.add_stem( names.join(':'), display_names.join(':') ) unless names.empty?
      yield child if block_given?
      child
    end

    #
    # Create stem (along with missing intermediaries).
    #
    #   # Create top-level 'foo' stem
    #   stem = JGrouper::Stem.create 'foo'
    #
    #   # Create top-level 'foo' stem with display name of 'Foo'
    #   stem = JGrouper::Stem.create 'foo', 'Foo'
    #
    #   # Create 'foo:bar:baz' stem, along with any missing intermediaries
    #   stem = JGrouper::Stem.create 'foo:bar:baz'
    #
    def self.create( name, display_name = nil )
      stem = root.add_stem name, display_name
      yield stem if block_given?
      stem
    end

    #
    # Find stem by name or returns +nil+.
    #
    #   stem = JGrouper::Stem.find(name)
    #   
    def self.find(name)
      stem = from_grouper StemFinder.findByName( GrouperSession.startRootSession, name, false ) # XXX How to handle sessions?
      yield stem if block_given?
      stem
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
      return nil if grouper.nil?
      new do |stem|
        stem.instance_variable_set :@grouper_stem, grouper # XXX Is this even needed?

        stem.display_name = grouper.getDisplayName
        stem.name         = grouper.getName
        stem.uuid         = grouper.getUuid
      end
    end

  end
end

