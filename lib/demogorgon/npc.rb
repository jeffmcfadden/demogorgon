require 'active_support/concern'

module Demogorgon
  module Npc
    extend ActiveSupport::Concern
  
    attr_accessor :id
    attr_accessor :name
    attr_accessor :description
    attr_accessor :short_description
    attr_accessor :inspect_description
      
  end
end