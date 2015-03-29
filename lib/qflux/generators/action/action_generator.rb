module Qflux
  module Generators
    module Action
      module ActionGenerator
        def self.included(thor)
          thor.class_eval do

            desc "act action_name", "generate an action with given name."
            def act(name)
              puts "TODO: Generate Action"
            end

          end
        end
      end
    end
  end
end