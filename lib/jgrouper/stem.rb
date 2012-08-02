
module JGrouper # :nodoc:
  #
  # = JGrouper::Stem - A Grouper stem
  #
  class Stem

    def initialize(stem)
      @stem = stem
      yield self if block_given?
      self
    end

    #
    # Return root stem.
    #
    #   root_stem = JGrouper::Stem.root_stem
    #
    def self.root_stem
      stem = self.new StemFinder.findRootStem( GrouperSession.startRootSession ) # XXX How to handle sessions?
      yield stem if block_given?
      stem
    end

    def to_s
      %w( name display_name uuid ).collect { |k| "#{k}=#{ self.send(k) }" }.join(' | ') 
    end

    #
    # Stem display name getter.
    #
    def display_name; @stem.getDisplayName; end
    #
    # Stem name getter.
    #
    def name; @stem.getName; end
    #
    # Stem UUID getter
    #
    def uuid; @stem.getUuid; end

  end
end

