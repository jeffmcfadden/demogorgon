Demogorgon.define do
  welcome <<~STR
    ------------------------------------------------------------
    Welcome to My Little Dungeon!

    You awake to find yourself lying on the floor of a cell in a dungeon. The door is open and the guard is lying on the floor in the hallway, unconscious.

    Type 'help' if you need it.
    ------------------------------------------------------------
    STR

  win_message "You win!"
  lose_message "You lose!"

  room do
    id :cell_1
    preposition "in"
    name "jail cell #1"
    short_description "a dingy, damp cell with rock walls and a rusting iron door."
    long_description "The jail cell is dark, damp, and old. The rock floor is worn smooth. There are lines on the wall where someone (you?) has been keeping track of the days. The bars of the old iron door are rusted, and the floor beneath is stained orange. A guard lies unconscious out in the hallway."

    path {
      direction :east
      destination :south_hallway
    }

    item do
      id :gross_bucket
      name "bucket"
      short_description "A small metal bucket. It looks pretty gross."
      long_description  "You look closely at the bucket and nearly pass out from the smell. It's clearly not something you want to know more about."
    end
  end

  room do
    id :cell_2
    preposition "in"
    name "jail cell #2"
    short_description "another dark and dingy jail cell."
    long_description "This jail cell is dark, but not as wet as the one you woke up in. There's a strange dark stain on the stone floor, but it doesn't look relevant."

    path :east, :central_hallway

  end

  room do
    id :cell_3
    preposition "in"
    name "jail cell #3"
    short_description "a third empty jail cell."
    long_description "This cell is completely empty, and the stone looks rather new. Perhaps it was recently renovated."

    path :east, :north_hallway

  end

  room do
    id :south_hallway
    preposition "in"
    name "the south hallway"
    short_description "Gross hallway with a guard lying asleep on the floor"
    long_description "The hallway is made of small stone pressed into the earth. Moss grows in the corners. The walls and ceiling appear to be made of brick of some kind."

    path :west, :cell_1
    path :north, :central_hallway

    on_visit -> (g){
      # puts "Hi you visited me and I ran some code"
    }

    npc do
      id :npc1
      name "An unconscious guard"
      nickname "guard"
      friendly true
      long_description "There's not much to see. The guard is unconscious, and doesn't appear to be carrying anything interesting."
    end

    item do
      id :dagger
      article "a"
      name "small dagger"
      synonyms "dagger"
      short_description "a small, sharp dagger."
      long_description "It's a small dagger. The blade is sharp, but it's unlikely to do much damage against a big monster."
      provides_light false
      carryable true
    end
  end

  room do
    id :central_hallway
    name "the central hallway"
    short_description "A plain bit of the hallway."
    long_description "The hallway is made of small stone pressed into the earth. Moss grows in the corners. The walls and ceiling appear to be made of brick of some kind."

    path :west,  :cell_2
    path :south, :south_hallway
    path :north, :north_hallway

    item do
      id :torch
      article "a"
      name "torch"
      short_description "Fire on a stick"
      long_description "It's a torch, about a foot long. It seems to burn without burning up."
      provides_light true
      carryable true
    end
  end

  room do
    id :north_hallway
    name "the north hallway"
    short_description "A plain bit of the hallway."
    long_description "The hallway is made of small stone pressed into the earth. Moss grows in the corners. The walls and ceiling appear to be made of brick of some kind."

    path :west,  :cell_3
    path :south, :central_hallway
    path :north, :corridor
  end

  room do
    id :corridor
    name "a dark corridor"
    short_description "You are in a dark corridor."
    long_description "The corridor has no light of its own, and seems to absorb any light that might leak in. Without your own light source, it's impossible to see in here."
    has_light false

    path :east,  :dark_stairs, true
    path :south, :north_hallway
  end

  room do
    id :dark_stairs
    preposition "on"
    name "a dark staircase"
    short_description "A dark spiral staircase."
    long_description "The stairs are made of stone, worn smooth from heavy foot traffic. The top of the stairs exits into a chamber of some kind, while the bottom exits into a dim chamber."
    has_light false

    path :west,  :corridor
    path :east, :central_chamber
  end

  room do
    id :central_chamber
    name "the central chamber"
    short_description "The center of a large chamber."
    long_description "The chamber is huge, stretching far over your head. It seems to be light by torches, but they're too high to be sure. "

    path :west,  :dark_stairs
    path :north, :north_chamber
    path :south, :south_chamber
  end

  room do
    id :south_chamber
    name "the south chamber"
    short_description "The south end of a large chamber."
    long_description "The chamber is huge, stretching far over your head. It seems to be light by torches, but they're too high to be sure."

    path :north, :central_chamber

    item do
      id :treasure
      article "some"
      name "treasure"
      synonyms "treasure"
      short_description "a small pile of gold coins"
      long_description "The coins seem to be stamped with an image of a crown. The pile isn't huge, but it's enough to keep you going for the rest of your life, anyway."
      carryable true

      on_take -> (g) {
        Demogorgon::Terminal.puts "You load the treasure into your pack. As your dig into the pile you notice something shiny. Removing some more coins you find a gleaming sword beneath the pile."
        g.item(:sword).unhide!
      }
    end

    item do
      id :sword
      name "gleaming sword"
      synonyms "sword"
      hidden true
      carryable true
    end
  end

  room do
    id :north_chamber
    name "the north chamber"
    short_description "The south end of a large chamber."
    long_description "The chamber is huge, stretching far over your head. It seems to be light by torches, but they're too high to be sure. In the center is a huge, angry troll."

    path :south, :central_chamber

    npc do
      id :troll
      name "Troll"
      friendly false
      on_attack -> (g) {
        Demogorgon::Terminal.puts "You attempt to attack the troll."

        if g.player.inventory.any? { |i| i.id == :sword }
          Demogorgon::Terminal.puts "You kill the troll. The treasure is yours!"
          g.win!
        else
          Demogorgon::Terminal.puts "You attack the troll, but you don't have the weapons to win. He bashes your head in!"
          Demogorgon::Terminal.puts "You are dead."
          g.lose!
        end

      }
    end
  end

  starting_location :cell_1
end