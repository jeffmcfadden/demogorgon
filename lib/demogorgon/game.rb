module Demogorgon
  class Game
    extend Buildable
    buildable_with :welcome, :starting_location

    attr_accessor :rooms
    attr_accessor :player
    attr_accessor :items
    attr_accessor :turn_count
    attr_accessor :over
    attr_accessor :current_location
    attr_accessor :commands

    def initialize(*)
      super

      self.rooms      = []
      self.over       = false
      self.turn_count = 0
      self.commands   = []
      self.player     = Player.new
    end

    def over?
      over
    end

    def over!
      self.over = true
    end

    def room(&block)
      @room = Demogorgon::Room.new
      @room.instance_eval(&block)
      @rooms << @room
    end

    def command(&block)
      @command = Demogorgon::Command.new
      @command.instance_eval(&block)
      @commands << @command
    end

    def start
      self.current_location = rooms.find{ |r| r.id == starting_location }
    end

    def status
      status = "You are #{current_location.preposition} #{current_location.name}.\n"
      status += current_location.items.collect{ |i| "There is a #{i.name} here." }.join( "\n" ) + "\n"
      status += current_location.npcs.collect{ |i| "#{i.name} is here." }.join( "\n" )
      status
    end

    def list_inventory
      if player.inventory.empty?
        Terminal.puts "You aren't carrying anything"
      else
        Terminal.puts "Inventory: " + player.inventory.collect{ |i| i.name }.join( ", " )
      end
    end

    def move(path)
      if current_location.paths.include? path.to_sym
        self.current_location = rooms.find{ |r| r.id == current_location.paths[path.to_sym] }
        self.current_location.visited(self)
      else
        Terminal.puts "You can't go that direction from here."
        Terminal.puts "Valid directions are: #{current_location.paths.keys.join( "," )}"
      end
    end

  end
end