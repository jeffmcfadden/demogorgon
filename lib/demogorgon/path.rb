module Demogorgon
  class Path
    extend Buildable
    buildable_with :direction, :destination, :requires_light

    def initialize
      self.requires_light = false
    end

    def requires_light?
      true == @requires_light
    end

  end
end