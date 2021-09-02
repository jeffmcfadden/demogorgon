module Demogorgon
  class NonPlayerCharacter
    extend Buildable
    buildable_with :id, :name, :friendly

    def initialize
      @on_attack = -> (g) {
        if friendly?
          Demogorgon::Terminal.puts "You can't attack #{name}."
        end
      }
    end

    def friendly?
      true == friendly
    end

    def on_attack(block)
      @on_attack = block
    end

    def attack!(game)
      @on_attack.(game) unless @on_attack.nil?
    end

  end
end