module Qflux
  module Generators
    module Store
      class StoreGenerator < Thor::Group
        include Thor::Actions

        attr_accessor :name
        argument :full_name

        desc "generate a store with given name."
        def store
          puts "Generating Store:"
          self.name = full_name.split("/").last
          render_template
        end


        def source_paths
          [File.dirname(__FILE__)]
        end

        private
        def render_template(filename="")
          template('templates/Store.coffee', "scripts/stores/#{full_name}Store.coffee")
        end
      end
    end
  end
end