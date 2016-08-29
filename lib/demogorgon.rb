require 'demogorgon/demogorgon'
require 'demogorgon/errors'
require 'demogorgon/version'

module Demogorgon
  def self.config
    yield self
  end
end