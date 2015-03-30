module Qflux
  module Generators
    module Action
      module ActionGenerator
        def self.included(thor)
          thor.class_eval do
            include Thor::Actions
            attr_accessor :name, :full_name
            
            desc "act action_name", "generate an action with given name."
            def act(full_name)
              puts "TODO: Generate Action"
            end

          end
        end
      end
    end
  end
end