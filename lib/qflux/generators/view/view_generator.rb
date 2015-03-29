module Qflux
  module Generators
    module View
      module ViewGenerator
        def self.included(thor)
          thor.class_eval do
            include Thor::Actions
            attr_accessor :view_name, :name
            desc "view view_name", "generate a view with given name."
            def view(name)
              self.view_name = name.split("/").last
              self.name = name
              create_view
            end

            def self.source_root
              File.dirname(__FILE__)
            end

            private
            def create_view
              template('templates/view.coffee', "scripts/views/#{name}.coffee")
            end
          end
        end
      end
    end
  end
end