module Qflux
  module Generators
    module Store
      module StoreGenerator
        def self.included(thor)
          thor.class_eval do

            desc "store store_name", "generate a store with given name."
            def store(name)
              puts "TODO: Generate Store"
            end
            
          end
        end
      end
    end
  end
end