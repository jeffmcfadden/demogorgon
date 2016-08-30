require 'demogorgon/demogorgon'
require 'demogorgon/game'
require 'demogorgon/npc'
require 'demogorgon/player'
require 'demogorgon/room'
require 'demogorgon/errors'
require 'demogorgon/version'

module Demogorgon
  def self.config
    yield self
  end
end