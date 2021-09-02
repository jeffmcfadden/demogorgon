Demogorgon.define do
  welcome "Welcome to My Little Dungeon!\n\nYou awake to find yourself lying on the floor of a cell in a dungeon. The door is open and the guard is lying on the floor in the hallway, unconscious.\n\nType 'help' if you need it."

  room do
    id :cell_1
    preposition "in"
    name "a jail cell"
    short_description "a dingy, damp cell with rock walls and a rusting iron door."
    long_description "The jail cell is dark, damp, and old. The rock floor is worn smooth. There are lines on the wall where someone (you?) has been keeping track of the days. The bars of the old iron door are rusted, and the floor beneath is stained orange. A guard lies unconscious out in the hallway."

    path :east, :south_hallway

    item do
      id :gross_bucket
      name "bucket"
      short_description "A small metal bucket. It looks pretty gross."
      long_description  "You look closely at the bucket and nearly pass out from the smell. It's clearly not something you want to know more about."
    end

    npc do
      id :npc1
      name "Bob"
      friendly false
      on_attack -> (g) {
        Demogorgon::Terminal.puts "You attempt to attack Bob."
      }
    end

  end

  room do
    id :cell_2
    preposition "in"
    name "A Jail Cell"
    short_description "A beautiful little cottage."
    long_description "A beautiful little while cottage set atop a vibrant green hill."

    path :east, :central_hallway

  end

  room do
    id :cell_3
    preposition "in"
    name "A Jail Cell"
    short_description "A beautiful little cottage."
    long_description "A beautiful little while cottage set atop a vibrant green hill."

    path :east, :north_hallway

  end

  room do
    id :south_hallway
    name "South hallway"
    short_description "Gross hallway with a guard lying asleep on the floor"
    long_description "A beautiful little while cottage set atop a vibrant green hill."

    path :west, :cell_1
    path :north, :central_hallway

    on_visit -> (g){
      # puts "Hi you visited me and I ran some code"
    }
  end

  room do
    id :central_hallway
    name "Central hallway"
    short_description "A beautiful little cottage."
    long_description "A beautiful little while cottage set atop a vibrant green hill."

    path :west,  :cell_2
    path :south, :south_hallway
    path :north, :north_hallway
  end

  room do
    id :north_hallway
    name "North hallway"
    short_description "A beautiful little cottage."
    long_description "A beautiful little while cottage set atop a vibrant green hill."

    path :west,  :cell_3
    path :south, :central_hallway
    path :north, :corridor
  end

  room do
    id :corridor
    name "Dark Corridor"
    short_description "A beautiful little cottage."
    long_description "A beautiful little while cottage set atop a vibrant green hill."

    path :east,  :dark_stairs
    path :south, :north_hallway
  end

  room do
    id :dark_stairs
    name "Dark stairs"
    short_description "A beautiful little cottage."
    long_description "A beautiful little while cottage set atop a vibrant green hill."

    path :west,  :corridor
    path :east, :central_chamber
  end

  room do
    id :central_chamber
    name "Central hallway"
    short_description "A beautiful little cottage."
    long_description "A beautiful little while cottage set atop a vibrant green hill."

    path :west,  :dark_stairs
    path :north, :north_chamber
    path :south, :south_chamber
  end

  room do
    id :south_chamber
    name "South chamber"
    short_description "A beautiful little cottage."
    long_description "A beautiful little while cottage set atop a vibrant green hill."

    path :north, :central_chamber
  end

  room do
    id :north_chamber
    name "North chamber"
    short_description "A beautiful little cottage."
    long_description "A beautiful little while cottage set atop a vibrant green hill."

    path :south, :central_chamber

    npc do
      id :troll
      name "Troll"
      friendly false
      on_attack -> (g) {
        Demogorgon::Terminal.puts "You attempt to attack the troll."
      }
    end
  end

  starting_location :cell_1
end