module Qflux
  module Generators
    module Constant
      class ConstantGenerator < Thor::Group
        include Thor::Actions
        class_option :resource, type: :boolean, aliases: ['-r'], default: false 
        class_option :constants, type: :array, aliases: ['-const'], default: []
        class_option :constants_file, type: :string, aliases: ['-cf'], default: "scripts/constants/AppConstants.coffee"

        attr_accessor :name, :default_const, :dest
        argument :full_name

        
        desc "generate an constant with given name."
        def api_endpoint
          puts "Generating Constant:"
          self.name = full_name.split("/").last
          self.default_const = []
          self.dest = options[:constants_file]

          if !File.exist?(dest)
            render_constants_template
          else
            append_file dest do

  col = ""
  if options[:resource]
    col = <<-OUT
    
    LOAD_#{name.pluralize.camelize.upcase}: null
    LOAD_#{name.singularize.camelize.upcase}: null
    CREATE_#{name.singularize.camelize.upcase}: null
    OUT
  end

  options[:constants].each do |con|
    col += <<-OUT
    #{con}: null 
    OUT
  end
              col
            end
          end
        end


        def source_paths
          [File.dirname(__FILE__)]
        end

        private
        def render_constants_template
          template('templates/AppConstants.coffee', dest)
        end
      end
    end
  end
end