module JGrouper # :nodoc:
  #
  # = JGrouper::GroupType - A Grouper group type
  #
  class GroupType

    attr_accessor :name, :uuid
    attr_reader :error

    def initialize
      @grouper_group_type = nil
      yield self if block_given?
      self
    end

    #
    # Find all group types.
    #
    #    group_types = JGrouper::GroupType.all do |group_type|
    #      ...
    #    end
    #
    def self.all
      group_types = Java::EduInternet2MiddlewareGrouper::GroupTypeFinder.findAll.collect { |gt| from_grouper gt }
      group_types.each { |_| yield _ } if block_given?
      group_types
    end

    #
    # Create group type.
    # 
    #     group_type = JGrouper::GroupType.create name
    #
    def self.create(name)
      group_type = from_grouper Java::EduInternet2MiddlewareGrouper::GroupType.createType( GrouperSession.startRootSession, name )
      yield group_type if block_given?
      group_type
    end

    #
    # Delete group type.  Returns +false+ on failure.
    #
    #    JGrouper::GroupType.delete(name)
    #
    def self.delete(name)
      group_type = find(name)
      return false if group_type.nil?
      group_type.delete
    end

    #
    # Delete group type.  Sets +error+ and returns +false+ on failure.
    #
    #     group_type.delete
    #
    def delete
      begin
        @grouper_group_type.delete GrouperSession.startRootSession # XXX How to handle sessions?
        return true
      rescue Exception => e
        @error = e
      end
      false
    end

    #
    # Find a group type by name.
    #
    #    group_type = JGrouper::GroupType.find(name)
    #
    def self.find(name)
      group_type = from_grouper Java::EduInternet2MiddlewareGrouper::GroupTypeFinder.find(name, false)
      yield group_type if block_given?
      group_type
    end

    #
    # Generate JGrouper::GroupType instance from JSON by calling +JSON.parse(json_string)+
    # 
    def self.json_create(json)
      new do |group_type|
        group_type.name = json['name']
        group_type.uuid = json['uuid']
      end
    end

    #
    # Return JSON representation of JGrouper::GroupType instance.
    #
    def to_json
      {
        :json_class   => self.class.name,
        :name         => self.name,
        :uuid         => self.uuid
      }.to_json
    end

    #
    # Return String representation of JGrouper::GroupType instance.
    #
    def to_s
      %w( name uuid ).collect { |k| "#{k}=#{ self.send(k) }" }.join(' | ') 
    end


    private

    def self.from_grouper(grouper)
      return nil if grouper.nil?
      new do |group_type|
        group_type.instance_variable_set :@grouper_group_type, grouper # XXX Is this even needed?

        group_type.name = grouper.getName
        group_type.uuid = grouper.getUuid
      end
    end

  end
end

