module Qflux
  module Generators
    module Action
      class ActionGenerator < Thor::Group
        include Thor::Actions

        attr_accessor :name
        argument :full_name

        class_option :view_action_only, :type=>:boolean, :default=>false
        class_option :server_action_only, :type=>:boolean, :default=>false

        desc "generate an action with given name."
        def act
          puts "Generating Action:"       
          self.name = full_name.split("/").last
          create_server_action_template unless options[:view_action_only]
          create_view_action_template unless options[:server_action_only]
        end

        # def self.source_root
        #   File.dirname(__FILE__)
        # end
        def source_paths
          [File.dirname(__FILE__)]
        end

        private
        def create_server_action_template
          template('templates/ServerActionCreators.coffee', 
            "scripts/actions/server/#{full_name}ActionCreators.coffee")
        end

        def create_view_action_template
          template('templates/ViewActionCreators.coffee', 
            "scripts/actions/view/#{full_name}ActionCreators.coffee")
        end
      end
    end
  end
end