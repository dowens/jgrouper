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

    #
    # Find group by name or returns +nil+.
    #
    #   group = JGrouper::Group.find(name)
    #   
    def self.find(name)
      group = from_grouper GroupFinder.findByName( GrouperSession.startRootSession, name, false ) # How to handle sessions?
      yield group if block_given?
      group
    end

    #
    # Generate JGrouper::Group instance from JSON by calling +JSON.parse(json_string)+
    # 
    def self.json_create(json)
      new do |stem|
        stem.display_name = json['display_name']
        stem.name         = json['name']
        stem.types        = json['types']
        stem.uuid         = json['uuid']
      end
    end

    #
    # Return JSON representation of JGrouper::Group instance.
    #
    def to_json
      {
        :json_class   => self.class.name,
        :display_name => self.display_name,
        :name         => self.name,
        :types        => self.types,
        :uuid         => self.uuid
      }.to_json
    end

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
        group.instance_variable_set :@grouper_group, grouper # Is this even needed?

        group.display_name = grouper.getDisplayName
        group.name         = grouper.getName
        group.uuid         = grouper.getUuid

        group.instance_variable_set :@types, grouper.getTypes.collect { |t| t.getName }
      end
    end

  end
end

