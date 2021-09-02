module Demogorgon
  class Item
    extend Buildable
    buildable_with :id, :name, :article, :short_description, :long_description, :carryable, :provides_light

    def initialize
      self.provides_light = false
      self.carryable      = false
      self.article        = "a"
    end

    def carryable?
      true == @carryable
    end

    def provides_light?
      @provides_light
    end
  end
end