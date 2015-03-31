module Qflux
  module Generators
    module Api
      class ApiEndpointGenerator < Thor::Group
        include Thor::Actions
        class_option :resource, type: :boolean, aliases: ['-r'], default: false 
        class_option :api_endpoint_methods, type: :array, aliases: ['-aem'], default: []
        class_option :api_endpoint_dir, type: :string, aliases: ['-aed'], default: "scripts/utils/api/"

        attr_accessor :name, :default_epos, :dest
        argument :full_name

        
        desc "generate an api endpoint with given name."
        def api_endpoint
          puts "Generating Endpoint:"
          self.name = full_name.split("/").last
          self.default_epos = []
          self.dest = options[:api_endpoint_dir] + "/#{full_name}API.coffee"

          if options[:resource] or !File.exist?(dest)
            render_api_endpoint_template
          else
            append_file dest do
              out = options[:api_endpoint_methods].collect do |epo|
  <<-OUT

  #{epo.to_s}: () ->
    APIUtils.setHeadersAndJson(r)
    norm = APIUtils.normalize#{name.singularize.camelize}Response(res)
    r.end (res) ->
      Server#{ name.singularize.camelize }ActionCreators.receive#{ name.singularize.camelize } res
  
  OUT
              end
              out.join("")
            end
          end
        end


        def source_paths
          [File.dirname(__FILE__)]
        end

        private
        def render_api_endpoint_template
          template('templates/ResourceAPI.coffee', "scripts/utils/api/#{full_name}API.coffee")
        end
      end
    end
  end
end