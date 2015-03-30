module Qflux
  module Generators
    module View
      module ViewGenerator
        def self.included(thor)
          thor.class_eval do
            include Thor::Actions
            attr_accessor :name, :full_name

            method_option :layout, type: :boolean, aliases: '-l', default: false

            desc "view c_name", "generate a view with given name."
            def view(full_name)
              byebug
              self.name = full_name.split("/").last
              self.full_name = full_name
              create_view
            end

            def self.source_root
              File.dirname(__FILE__)
            end

            private
            def create_view
              template('templates/view.coffee', "scripts/views/#{full_name}.coffee")
            end
          end
        end
      end
    end
  end
end