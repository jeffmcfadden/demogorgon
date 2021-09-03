module Demogorgon
  class Item
    extend Buildable
    buildable_with :id, :name, :article, :short_description, :long_description, :carryable, :provides_light, :hidden

    attr_accessor :on_take_block

    def initialize
      self.provides_light = false
      self.carryable      = false
      self.article        = "a"
      self.hidden         = false
      @synonyms           = []
      @on_take_block      = -> (g){}
    end

    def synonyms(s = nil)
      if s.nil?
        return @synonyms
      elsif s.is_a? String
        @synonyms = s.downcase.split(",").collect{ |c| c.strip }
      else
        raise "synonyms must be a string"
      end
    end

    def carryable?
      true == @carryable
    end

    def provides_light?
      @provides_light
    end

    def on_take(block)
      @on_take_block = block
    end

    def hidden?
      @hidden
    end

    def unhide!
      @hidden = false
    end

    def hide!
      @hidden = true
    end

  end
end