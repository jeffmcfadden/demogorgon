module Demogorgon
  class Player
    attr_accessor :inventory

    def initialize
      super

      self.inventory = []
    end

  end
end