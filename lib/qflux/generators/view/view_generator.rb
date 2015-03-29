module Qflux
  module Generators
    module View
      module ViewGenerator
        def self.included(thor)
          thor.class_eval do

            desc "view view_name", "generate a view with given name."
            def view(name)
              puts "TODO: View Store"
            end
            
          end
        end
      end
    end
  end
end