require 'thor'
module Qflux
  class Builder < Thor
    desc "new FLUX_APP_NAME", "This will create a new react flux application base project structure."

    long_desc <<-NEW_FLUX_APP_DESC

    `new FLUX_APP_NAME` will create a new react flux project
     with the given name. 

     This will create boilerplate app, router,
     dispatcher, base constants, gulp setup, env.json, 
     conventional directory structure, custom flux utilities,
     and optional authentication.

    NEW_FLUX_APP_DESC
    def new(name)
      puts "TODO: create flux app with name: #{name}"
    end

  end
end