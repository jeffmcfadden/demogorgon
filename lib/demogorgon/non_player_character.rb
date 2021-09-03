module Demogorgon
  class NonPlayerCharacter
    extend Buildable
    buildable_with :id, :name, :nickname, :friendly, :long_description

    attr_accessor :on_attack_block

    def initialize
      @on_attack_block = -> (g) {
        if friendly?
          Demogorgon::Terminal.puts "You can't attack #{name}."
        end
      }
    end

    def friendly?
      true == friendly
    end

    def on_attack(block)
      @on_attack_block = block
    end

    def attack!(game)
      @on_attack_block.(game) unless @on_attack_block.nil?
    end

  end
end