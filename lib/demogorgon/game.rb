module Demogorgon
  class Game
    attr_accessor :player
    attr_accessor :rooms
    attr_accessor :items
    attr_accessor :npcs
    attr_accessor :over
    
    def initialize
      self.player = nil
      self.rooms  = []
      self.items  = []
      self.npcs   = []
      self.over   = false
    end
    
    def load_from_directory(dir)
      puts "load_from_directory( #{dir} )"
    end
    
    def load_from_savefile
    end
    
    def save
    end
    
    def user_command(command)
      if command == "exit"
        puts "Your wish is my command. See you soon."
        puts " "
        user_exit
      else
        puts "I don't understand #{command}"
        puts " "
      end
    end
    
    def not_over?
      !over
    end
    
    def user_exit
      self.over = true
    end
    
  end
end