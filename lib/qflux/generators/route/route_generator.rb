module Qflux
  module Generators
    module Route
      module RouteGenerator
        def self.included(thor)
          thor.class_eval do
            include Thor::Actions
            attr_accessor :name, :full_name
            
            desc "route route_name", "generate a route with given name."
            def route(full_name)
              puts "TODO: Generate Route"
            end
            
          end
        end
      end
    end
  end
end