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

    def light_present?
      current_location.has_light? || player.inventory.any?{ |i| i.provides_light? }
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

    def move(direction)
      if available_directions.include? direction.to_sym
        self.current_location = room_in_direction(direction)
        self.current_location.visited(self)
      else
        Terminal.puts "You can't go that direction from here."
        Terminal.puts "Valid directions are: #{available_directions.join( ", " )}"
      end
    end

    def room_in_direction(direction)
      room_id = current_location.paths.find{ |p| p.direction == direction }.destination
      rooms.find{ |r| r.id == room_id }
    end

    def available_paths
      current_location.paths.select{ |p| self.light_present? || !(p.requires_light?) }
    end

    def available_destinations
      available_paths.collect{ |p| p.destination }
    end

    def available_directions
      available_paths.collect{ |p| p.direction }
    end

  end
end