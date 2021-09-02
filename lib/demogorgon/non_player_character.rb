module Demogorgon
  class NonPlayerCharacter
    extend Buildable
    buildable_with :id, :name, :friendly, :on_attack

    def initialize
      self.on_attack = -> (g, cmd) {
        if friendly?
          Demogorgon::Terminal.puts "You can't attack #{name}."
        end
      }
    end

    def friendly?
      true == friendly
    end

    def attack!(game)
      self.on_attack(game) unless on_attack.nil?
    end
  end
end