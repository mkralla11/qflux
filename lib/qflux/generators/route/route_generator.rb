module Qflux
  module Generators
    module Route
      module RouteGenerator
        def self.included(thor)
          thor.class_eval do

            desc "route route_name", "generate a route with given name."
            def route(name)
              puts "TODO: Generate Route"
            end
            
          end
        end
      end
    end
  end
end