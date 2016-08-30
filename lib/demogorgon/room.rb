require 'active_support/concern'

module Demogorgon
  module Room
    extend ActiveSupport::Concern
  
    attr_accessor :id
    attr_accessor :name
    attr_accessor :exits
    attr_accessor :description
    attr_accessor :short_description
    attr_accessor :inspect_description
    attr_accessor :visited
    attr_accessor :lights_on  
  
  end
end