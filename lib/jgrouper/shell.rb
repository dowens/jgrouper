require_relative '../jgrouper'

require 'pry'

module JGrouper # :nodoc:
  #
  # = JGrouper::Shell - JGrouper interactive shell
  #
  # == Usage
  #
  #   # Launch
  #   % jgrouper
  #
  # === Group Types
  #
  # Any JGrouper::GroupType methods, such as:
  #
  #   JGrouper::Shell:0> group_type.all
  #
  # === Stems
  #
  # Any JGrouper::Stem methods, such as:
  #
  #   JGrouper::Shell:0> stem.root
  #
  # === Groups
  #
  # Any JGrouper::Group methods, such as:
  #
  #   JGrouper::Group:0> group.find 'name'
  #
  # === Subjects
  #
  # Any JGrouper::Subject methods, such as:
  #
  #   JGrouper::Shell:0> subject.root
  #
  class Shell

    def initialize
      yield self if block_given?
      self
    end

    #
    # Access JGrouper::GroupType commands
    #
    def group_type
      JGrouper::GroupType
    end

    #
    # Start JGrouper shell
    #
    def self.run!
      JGrouper.home ENV['GROUPER_HOME'] if ENV['GROUPER_HOME']
      shell = new do |shell|
        Pry.start shell,
                  :prompt => [ proc { |obj, nest_level| "#{obj.class.name}:#{nest_level}> " },
                               proc { "> " }
                             ]
      end
    end

    #
    # Access JGrouper::Group commands
    #
    def group
      JGrouper::Group
    end

    #
    # Access JGrouper::Stem commands
    #
    def stem
      JGrouper::Stem
    end

    #
    # Access JGrouper::Subject commands
    #
    def subject
      JGrouper::Subject
    end

  end
end

