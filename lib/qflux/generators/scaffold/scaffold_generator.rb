module Qflux
  module Generators
    module Scaffold
      class ScaffoldGenerator < Thor::Group
        include Thor::Actions
        class_option :resource, type: :boolean, default: true
        attr_accessor :name
        argument :full_name

        
        desc "generate all necessary boilerplate for a given resource."
        def scaffold
          puts "Generating Scaffolding for #{full_name}..."
          generators = [
            Qflux::Generators::Action::ActionGenerator,
            Qflux::Generators::Route::RouteGenerator,
            Qflux::Generators::Store::StoreGenerator,
            Qflux::Generators::View::ViewGenerator,
            Qflux::Generators::Api::ApiEndpointGenerator,
            Qflux::Generators::Constant::ConstantGenerator
          ]
          generators.each do |g|
            invoke g, [full_name], :resource=>true
          end
        end
      end
    end
  end
end