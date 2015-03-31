module Qflux
  module Generators
    module Route
      class RouteGenerator < Thor::Group
        include Thor::Actions
        class_option :resource, type: :boolean, aliases: ['-r'], default: false 
        class_option :routes, type: :array, default: []

        attr_accessor :name, :dest, :full_path
        argument :full_name

        
        desc "generate a route with given name."
        def route
          puts "Generating Route(s):"
          self.name = full_name.split("/").last
          self.dest = "scripts/Routes.coffee"
          self.full_path = full_name.pluralize.downcase + "/"

          if !File.exist?(dest)
            render_template
          end

          handle_insertion
        end

        def source_paths
          [File.dirname(__FILE__)]
        end

        private
        def render_template(filename="")
          template('templates/Routes.coffee', dest)
        end


        def handle_insertion
          resources_page = "#{full_name.pluralize.camelize.gsub('::', '')}Page"
          resource_page = "#{full_name.singularize.camelize.gsub('::', '')}Page"
          resource_new = "#{full_name.camelize.gsub('::', '')}New"     
          resource_path =  full_name.pluralize.downcase    
          append_file dest do

            col = ""

            if options[:resource]
              col = <<-OUT

    Route 
      name: '#{full_name.pluralize.dasherize.gsub('/', '-').downcase}'
      path: "/#{resource_path}" 
      handler: #{resources_page},

    Route 
      name: "#{full_name.singularize.dasherize.gsub('/', '-').downcase}" 
      path: "/#{resource_path}/:#{name.singularize.camelize.gsub('::', '')}Id" 
      handler: #{resource_page},

    Route 
      name: "#{full_name.singularize.dasherize.gsub('/', '-').downcase}-new" 
      path: "/#{resource_path}/new" 
      handler: #{resource_new}

      OUT
            end

            options[:routes].each do |con|
              col += <<-OUT
    Route 
      name: "#{con.dasherize.gsub('/', '-').downcase}" 
      path: "/#{resource_path}/#{con}" 
      handler: #{full_name.camelize.gsub('::', '')}
            
      OUT
            end
            col
          end

          insert_into_file dest, :before => "module.exports =" do
            col = ""
            if options[:resource]
              {resources_page=>'Index', resource_page=>'Show', resource_new=>'New'}.each_pair do |var_name, view_name|
                col += <<-OUT
#{var_name} = require('./views/#{full_path}#{view_name}.coffee')
OUT
              end
            end
            options[:routes].each do |con|
              col += <<-OUT

#{con.camelize.gsub('::', '')} = require('./views/#{full_path}#{con.camelize}.coffee')
OUT
            end
            col
          end
        end

      end
    end
  end
end