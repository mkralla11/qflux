module Qflux
  module Generators
    module Store
      class StoreGenerator < Thor::Group
        include Thor::Actions

        attr_accessor :name
        argument :full_name

        desc "generate a store with given name."
        def store
          puts "TODO: Generate Store"
        end


        def source_paths
          [File.dirname(__FILE__)]
        end
      end
    end
  end
end