require 'qflux/generators/action/action_generator'
require 'qflux/generators/route/route_generator'
require 'qflux/generators/scaffold/scaffold_generator'
require 'qflux/generators/store/store_generator'
require 'qflux/generators/view/view_generator'

module Qflux
  module Generators
    class Generate < Thor
      include Qflux::Generators::Action::ActionGenerator
      include Qflux::Generators::Route::RouteGenerator
      include Qflux::Generators::Scaffold::ScaffoldGenerator
      include Qflux::Generators::Store::StoreGenerator
      include Qflux::Generators::View::ViewGenerator
    end
  end
end