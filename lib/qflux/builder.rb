require 'thor'
require 'qflux/generators/generate'
require 'active_support/core_ext/string'
#require 'byebug'

module Qflux
  class Builder < Thor
    include Thor::Actions
    attr_accessor :name, :full_name

    desc "new FLUX_APP_NAME", "This will create a new react flux application base project structure."

    long_desc <<-NEW_FLUX_APP_DESC

    `new FLUX_APP_NAME` will create a new react flux project
     with the given name. 

     This will create boilerplate app, router,
     dispatcher, base constants, gulp setup, env.json, 
     conventional directory structure, custom flux utilities,
     and optional authentication.

    NEW_FLUX_APP_DESC

    def new(full_name)
      self.name = full_name.split("/").last
      self.full_name = full_name
      puts "creating new flux app with name: #{name}"
      directory('%name%')
      inside full_name do 
        invoke 'qflux:generators:generate:view', ['App'], layout:true
      end
    end

    def self.source_root
      File.dirname(__FILE__)
    end

    GEN_DESC = ["generate COMMANDS", "generator sub module for creating a subset of boilerplate."]
    
    desc *GEN_DESC
    subcommand "generate", Qflux::Generators::Generate
    desc *GEN_DESC
    subcommand "g", Qflux::Generators::Generate
  end
end