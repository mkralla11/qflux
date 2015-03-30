module Qflux
  module Generators
    module Scaffold
      module ScaffoldGenerator
        def self.included(thor)
          thor.class_eval do
            include Thor::Actions
            attr_accessor :name, :full_name
            
            desc "scaffold resource_name", "generate all necessary boilerplate for a given resource."
            def scaffold(full_name)
              generators = [
                :store,
                :act,
                :view,
                :route
              ]
              generators.each do |g|
                invoke g
              end
            end

          end
        end
      end
    end
  end
end