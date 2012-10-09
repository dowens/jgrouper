module JGrouper # :nodoc:
  #
  # = JGrouper::Group - A Grouper group
  #
  class Group

    attr_accessor :display_name, :name, :uuid
    attr_reader   :types

    def initialize
      @grouper_group = nil
      yield self if block_given?
      self
    end

# XXX     #
# XXX     # Create child stem (along with missing intermediaries).
# XXX     #
# XXX     #   # Create child stem 'foo'
# XXX     #   child = stem.add_stem 'foo'
# XXX     #
# XXX     #   # Create child stem 'foo' with display name of 'Foo'
# XXX     #   child = stem.add_stem 'foo', 'Foo'
# XXX     #
# XXX     #   # Create child stem 'foo:bar:baz' along with any missing intermediaries
# XXX     #   child = stem.add_stem 'foo:bar:baz'
# XXX     #
# XXX     #
# XXX     def add_stem( name, display_name = nil )
# XXX       # TODO What if names.size != display_names.size?
# XXX       names         = name.split ':'
# XXX       display_names = display_name.nil? ? names.clone.split : display_name.split(':')
# XXX 
# XXX       name, display_name = names.shift, display_names.shift
# XXX 
# XXX       child = JGrouper::Stem.find self.name.empty? ? name : [ self.name, name ].join(':') # TODO Yuck
# XXX       child = JGrouper::Stem.from_grouper @grouper_stem.addChildStem(name, display_name) if child.nil?
# XXX 
# XXX       # TODO What if child can't be created?
# XXX       child = child.add_stem( names.join(':'), display_names.join(':') ) unless names.empty?
# XXX       yield child if block_given?
# XXX       child
# XXX     end
# XXX 
# XXX     #
# XXX     # Create stem (along with missing intermediaries).
# XXX     #
# XXX     #   # Create top-level 'foo' stem
# XXX     #   stem = JGrouper::Stem.create 'foo'
# XXX     #
# XXX     #   # Create top-level 'foo' stem with display name of 'Foo'
# XXX     #   stem = JGrouper::Stem.create 'foo', 'Foo'
# XXX     #
# XXX     #   # Create 'foo:bar:baz' stem, along with any missing intermediaries
# XXX     #   stem = JGrouper::Stem.create 'foo:bar:baz'
# XXX     #
# XXX     def self.create( name, display_name = nil )
# XXX       stem = root.add_stem name, display_name
# XXX       yield stem if block_given?
# XXX       stem
# XXX     end

    #
    # Find group by name or returns +nil+.
    #
    #   group = JGrouper::Group.find(name)
    #   
    def self.find(name)
      group = from_grouper GroupFinder.findByName( GrouperSession.startRootSession, name, false ) # XXX How to handle sessions?
      yield group if block_given?
      group
    end

# XXX     #
# XXX     # Generate JGrouper::Stem instance from JSON by calling +JSON.parse(json_string)+
# XXX     # 
# XXX     def self.json_create(json)
# XXX       new do |stem|
# XXX         stem.display_name = json['display_name']
# XXX         stem.name         = json['name']
# XXX         stem.uuid         = json['uuid']
# XXX       end
# XXX     end
# XXX 
# XXX     #
# XXX     # Return JSON representation of JGrouper::Stem instance.
# XXX     #
# XXX     def to_json
# XXX       {
# XXX         :json_class   => self.class.name,
# XXX         :display_name => self.display_name,
# XXX         :name         => self.name,
# XXX         :uuid         => self.uuid
# XXX       }.to_json
# XXX     end

    #
    # Return String representation of JGrouper::Group instance.
    #
    def to_s
      %w( name display_name uuid ).collect { |k| "#{k}=#{ self.send(k) }" }.join(' | ') + " | types=#{ types.join(',') }"
    end

    private

    def self.from_grouper(grouper)
      return nil if grouper.nil?
      new do |group|
        group.instance_variable_set :@grouper_group, grouper # XXX Is this even needed?

        group.display_name = grouper.getDisplayName
        group.name         = grouper.getName
        group.uuid         = grouper.getUuid

        group.instance_variable_set :@types, grouper.getTypes.collect { |t| t.getName }
      end
    end

  end
end

