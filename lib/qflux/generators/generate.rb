require 'qflux/generators/action/action_generator'
require 'qflux/generators/route/route_generator'
require 'qflux/generators/scaffold/scaffold_generator'
require 'qflux/generators/store/store_generator'
require 'qflux/generators/view/view_generator'
require 'qflux/generators/api/api_endpoint_generator'
require 'qflux/generators/constant/constant_generator'

module Qflux
  module Generators
    class Generate < Thor
      #include Qflux::Generators::Action::ActionGenerator
      #include Qflux::Generators::Route::RouteGenerator
      #include Qflux::Generators::Scaffold::ScaffoldGenerator
      #include Qflux::Generators::Store::StoreGenerator
      #include Qflux::Generators::View::ViewGenerator
      
      register(
        Qflux::Generators::Action::ActionGenerator, 
        "act", 
        "act resource_name", 
        "generate an action with given name."
      )
      register(
        Qflux::Generators::Route::RouteGenerator, 
        "route", "route resource_name", 
        "generate an route with given name."
      )
      register(
        Qflux::Generators::Scaffold::ScaffoldGenerator, 
        "scaffold", 
        "scaffold resource_name", 
        "generate an scaffold with given name."
      )
      register(
        Qflux::Generators::Store::StoreGenerator, 
        "store", 
        "store resource_name", 
        "generate an store with given name."
      )
      register(
        Qflux::Generators::View::ViewGenerator, 
        "view", 
        "view resource_name", 
        "generate a view with given name."
      )
      register(
        Qflux::Generators::Api::ApiEndpointGenerator, 
        "api_endpoint", 
        "api_endpoint resource_name", 
        "generate a api_endpoint with given name."
      )
      register(
        Qflux::Generators::Constant::ConstantGenerator, 
        "constant", 
        "constant resource_name", 
        "generate a api_endpoint with given name."
      )
    end
  end
end