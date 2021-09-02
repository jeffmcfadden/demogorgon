require 'tty-screen'
require 'pastel'
require 'demogorgon/terminal'
require 'demogorgon/buildable'
require 'demogorgon/item'
require 'demogorgon/room'
require 'demogorgon/player'
require 'demogorgon/non_player_character'
require 'demogorgon/game'
require 'demogorgon/command'
require 'demogorgon/version'


module Demogorgon
  def self.default_commands
    commands =  []

    commands << Demogorgon::Command.new("north", ["n"]){ |g| g.move(:north) }
    commands << Demogorgon::Command.new("south", ["s"]){ |g| g.move(:south) }
    commands << Demogorgon::Command.new("east", ["e"]){ |g| g.move(:east) }
    commands << Demogorgon::Command.new("west", ["w"]){ |g| g.move(:west) }

    commands << Demogorgon::Command.new("inventory", ["i"]){ |g| g.list_inventory }

    commands << Demogorgon::Command.new("help", ["h"]) { |g| Terminal.puts "Move around by typing directions like 'north', 'south', etc. You can look around in more detail by typing 'look'. You can check your inventory by typing 'inventory'. Other common commands include 'take', 'get', 'open'. Not all commands are available all the time. Use your imagination." }

    commands << Demogorgon::Command.new("look", ["l"]) do |g, cmd|
      ignore_words = ['look', 'l', 'at', 'on']

      cmd = cmd.split( " " ).delete_if{ |w| ignore_words.include? w }.join( " " ).strip

      if cmd == ""
        Terminal.puts g.current_location.long_description
        Terminal.puts "There are exits to the #{g.current_location.paths.keys.join(', ')}"
      elsif item = g.current_location.items.find{ |i| i.name.downcase == cmd }
        Terminal.puts item.long_description
      else
        Terminal.puts "I don't see a #{cmd} here."
      end

    end

    commands << Demogorgon::Command.new("take", ["t", "get", "g"]) do |g, cmd|
      item_name = cmd.strip.split( " " ).last&.downcase
      if item_name.nil?
        Terminal.puts "I'm not sure what you want to take."
      elsif item = g.current_location.items.find{ |i| i.name.downcase == item_name }
        if item.carryable?
          g.player.inventory << item
          Terminal.puts "You are now carrying #{item.article} #{item.name}."
        else
          Terminal.puts "You can't carry that."
        end
      else
        Terminal.puts "There is no #{item_name} here to pick up."
      end
    end

    commands << Demogorgon::Command.new("attack", ["a", "kill", "fight"]) do |g, cmd|

      name = cmd.downcase.split( " " ).last

      if name == ""
        Terminal.puts "You need to choose who to attack. For example, 'attack monster'."
      elsif npc = g.current_location.npcs.find{ |i| i.name.downcase == name }
        npc.attack!(g)
      else
        Terminal.puts "I don't see #{name} here."
      end

    end


    commands << Demogorgon::Command.new("quit", ["q", "exit"]){ |g|
      Terminal.puts "Goodbye"
      g.over!
    }

    commands
  end

  def self.define(&block)
    @game = Demogorgon::Game.new
    @game.commands = Demogorgon.default_commands

    @game.instance_eval(&block)
    @game
  end
end