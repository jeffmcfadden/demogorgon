module Demogorgon
  class Room
    extend Buildable
    buildable_with :id, :name, :short_description, :long_description, :on_visit, :preposition

    attr_accessor :visit_count
    attr_accessor :paths
    attr_accessor :items
    attr_accessor :npcs

    def initialize
      super

      self.visit_count = 0
      self.paths = {}
      self.items = []
      self.npcs  = []
      self.preposition = "at"
    end

    def visited(game)
      self.visit_count += 1
      on_visit(game) unless on_visit.nil?
    end

    def path(direction, room)
      self.paths[direction] = room
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