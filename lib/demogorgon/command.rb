module Demogorgon
  class Command
    extend Buildable
    buildable_with :keyword, :synonyms

    attr_accessor :block

    def initialize(keyword, synonyms = [], &block)
      self.keyword  = keyword
      self.synonyms = synonyms
      self.block    = block
    end


  end
end