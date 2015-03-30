module Qflux
  module Generators
    module Api
      module ApiEndpointGenerator
        def self.included(thor)
          thor.class_eval do
            include Thor::Actions
            attr_accessor :name, :full_name
            
            desc "api_endpoint api_endpoint_name", "generate an api endpoint with given name."
            def api_endpoint(full_name)
              puts "TODO: Generate Api Endpoint"
            end

          end
        end
      end
    end
  end
end