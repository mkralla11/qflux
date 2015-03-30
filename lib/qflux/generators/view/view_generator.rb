module Qflux
  module Generators
    module View
      class ViewGenerator < Thor::Group
        include Thor::Actions

        attr_accessor :name, :template_name, :full_path
        argument :full_name

        class_option :layout, type: :boolean, aliases: '-l', default: false
        class_option :common, type: :boolean, aliases: ['-c', '-g', '--shared', '--global'], default: false
        class_option :connect_to_stores, aliases: ['-cts'], default: true
        class_option :resource, type: :boolean, aliases: ['-r'], default: false

        desc "generate a view with given name."
        def view
           puts "Generating View(s):"
          self.name = full_name.split("/").last

          if options[:common]
            self.template_name = full_name
            self.full_path = "common/" + full_name
            create_template
          elsif options[:layout]
            self.template_name = self.full_path = full_name
            create_template
          elsif options[:resource]
            self.full_path = full_name.pluralize.downcase + "/"
            ['New', 'Index', 'Show'].each do |filename|
              self.template_name = full_name.underscore.camelize + filename
              create_template(filename)
            end
          end
        end

        def source_paths
          [File.dirname(__FILE__)]
        end

        private
        def create_template(filename="")
          template('templates/view.coffee', "scripts/views/#{full_path}#{filename}.coffee")
        end
      end
    end
  end
end