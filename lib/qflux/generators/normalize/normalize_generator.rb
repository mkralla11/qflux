module Qflux
  module Generators
    module Normalize
      class NormalizeGenerator < Thor::Group
        include Thor::Actions
        class_option :resource, type: :boolean, aliases: ['-r'], default: false 
        class_option :normalizers, type: :array, aliases: ['-norms'], default: []
        class_option :normalizer_file, type: :string, aliases: ['-cf'], default: "scripts/utils/api/Utils.coffee"

        attr_accessor :name, :default_const, :dest
        argument :full_name

        
        desc "generate an constant with given name."
        def norm
          puts "Generating Constant:"
          self.name = full_name.split("/").last
          self.default_const = []
          self.dest = options[:normalizer_file]

          if !File.exist?(dest)
            render_constants_template
          end

          handle_insertion
        end


        def source_paths
          [File.dirname(__FILE__)]
        end

        private
        def render_constants_template
          template('templates/Utils.coffee', dest)
        end


def handle_insertion
          resources = full_name.pluralize.camelize.gsub('::', '')
          resource = full_name.singularize.camelize.gsub('::', '')

          resource_path =  full_name.pluralize.downcase    
          append_file dest do

            col = ""

            if options[:resource]
              col = <<-OUT

  normalize#{resources}Response: (res)->
    SessionStore.updateHeadersFromResponse(res)
    return res if _normalizeErrors(res)
    normalize res.body, 
      #{resources.underscore}: arrayOf(#{resource})
  
  normalize#{resource}Response: (res)->
    SessionStore.updateHeadersFromResponse(res)
    return res if _normalizeErrors(res)
    normalize res.body, 
      #{resource.underscore}: #{resource}

      OUT
            end
            col
          end

          insert_into_file dest, :before => "module.exports =" do
            col = ""
            if options[:resource]
                col += <<-OUT
#{resource} = new Schema '#{resource.underscore}'

OUT
            end
            col
          end
        end
      end
    end
  end
end