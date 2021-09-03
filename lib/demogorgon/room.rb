module Demogorgon
  class Room
    extend Buildable
    buildable_with :id, :name, :short_description, :long_description, :first_visit, :on_visit, :preposition, :has_light

    attr_accessor :visit_count
    attr_accessor :paths
    attr_accessor :items
    attr_accessor :npcs

    def initialize
      super

      self.visit_count = 0
      self.paths = []
      self.items = []
      self.npcs  = []
      self.preposition = "at"
      self.has_light   = true

      self.first_visit = -> (g) { self.short_description }
    end

    def visited(game)
      self.visit_count += 1

      if self.visit_count == 1
        Terminal.puts self.first_visit
      end

      on_visit(game) unless on_visit.nil?
    end

    def has_light?
      @has_light
    end

    def path(*args, &block)
      if block.nil?
        @path = Path.new
        @path.direction      = args[0]
        @path.destination    = args[1]
        @path.requires_light = args[2]
      else
        @path = Path.new
        @path.instance_eval(&block)
      end

      @paths << @path
    end

    def visible_items
      items.select{ |i| !(i.hidden?) }
    end

    def item(&block)
      @item = Demogorgon::Item.new
      @item.instance_eval(&block)
      @items << @item
    end

    def npc(&block)
      @npc = Demogorgon::NonPlayerCharacter.new
      @npc.instance_eval(&block)
      @npcs << @npc
    end

  end
end