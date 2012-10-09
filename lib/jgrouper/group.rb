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

