module Demogorgon
  class Item
    extend Buildable
    buildable_with :id, :name, :article, :short_description, :long_description, :carryable

    def initialize
      self.carryable = false
      self.article = "a"
    end

    def carryable?
      true == carryable
    end
  end
end