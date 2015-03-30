module Qflux
  module Generators
    module Route
      class RouteGenerator < Thor::Group
        include Thor::Actions

        attr_accessor :name
        argument :full_name

        
        desc "generate a route with given name."
        def route
          puts "TODO: Generate Route"
        end

        def source_paths
          [File.dirname(__FILE__)]
        end

      end
    end
  end
end