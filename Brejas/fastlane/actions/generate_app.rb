module Fastlane
    module Actions
        module SharedValues
            GENERATE_APP_CUSTOM_VALUE = :GENERATE_APP_CUSTOM_VALUE
        end

        class GenerateAppAction < Action
            def self.run(params)
                # fastlane will take care of reading in the parameter and fetching the environment variable:
                UI.message "Parameter workspace: #{params[:workspace]}"
                UI.message "Parameter scheme: #{params[:scheme]}"
                UI.message "Parameter configuration: #{params[:configuration]}"
                UI.message "Parameter destination: #{params[:destination]}"
                UI.message "Parameter output_path: #{params[:output_path]}"

                workspace = (params[:workspace]).to_s
                scheme = (params[:scheme]).to_s
                configuration = (params[:configuration]).to_s
                destination = (params[:destination]).to_s
                output_path = (params[:output_path]).to_s

                FileUtils.rm_r output_path if Dir.exist?(output_path)

                FileUtils.mkdir_p output_path

                a = <<-EOF
                bash -cx "xcodebuild -workspace $(pwd)/'#{workspace.to_s.strip}' \
                -scheme '#{scheme.to_s.strip}' -destination '#{destination.to_s.strip}' \
                -configuration '#{configuration.to_s.strip}' clean build \
                CONFIGURATION_BUILD_DIR='$(pwd)/#{output_path}'"
                EOF
                puts a.to_s
                sh a

                sh "cd '#{output_path}'"
                result = sh "find `pwd` -name '*.app'"

                # Actions.lane_context[SharedValues::GENERATE_APP_CUSTOM_VALUE] = "my_val"
            end

            #####################################################
            # @!group Documentation
            #####################################################

            def self.description
                'A short description with <= 80 characters of what this action does'
            end

            def self.details
                # Optional:
                # this is your chance to provide a more detailed description of this action
                'You can use this action to do cool things...'
            end

            def self.available_options
                # Define all options your action supports.

                # Below a few examples
                [
                    FastlaneCore::ConfigItem.new(key: :workspace,
                                                 env_name: 'FL_BUILD_APP_WORKSPACE', # The name of the environment variable
                                                 description: 'Workspace for BuildAppAction', # a short description of this parameter
                                                 verify_block: proc do |value|
                                                     UI.user_error!("No workspace for BuildAppAction given, pass using `workspace: 'workspace'`") unless value && !value.empty?
                                                     # UI.user_error!("Couldn't find file at path '#{value}'") unless File.exist?(value)
                                                 end),
                    FastlaneCore::ConfigItem.new(key: :scheme,
                                                 env_name: 'FL_BUILD_APP_SCHEME', # The name of the environment variable
                                                 description: 'Scheme for BuildAppAction', # a short description of this parameter
                                                 verify_block: proc do |value|
                                                     UI.user_error!("No scheme for BuildAppAction given, pass using `scheme: 'scheme'`") unless value && !value.empty?
                                                     # UI.user_error!("Couldn't find file at path '#{value}'") unless File.exist?(value)
                                                 end),
                    FastlaneCore::ConfigItem.new(key: :destination,
                                                 env_name: 'FL_BUILD_APP_DESTINATION', # The name of the environment variable
                                                 description: 'Destination for BuildAppAction', # a short description of this parameter
                                                 verify_block: proc do |value|
                                                     UI.user_error!("No destination for BuildAppAction given, pass using `destination: 'destination'`") unless value && !value.empty?
                                                     # UI.user_error!("Couldn't find file at path '#{value}'") unless File.exist?(value)
                                                 end),
                    FastlaneCore::ConfigItem.new(key: :configuration,
                                                 env_name: 'FL_BUILD_APP_CONFIGURATION', # The name of the environment variable
                                                 description: 'Configuration for BuildAppAction', # a short description of this parameter
                                                 verify_block: proc do |value|
                                                     UI.user_error!("No configuration for BuildAppAction given, pass using `configuration': 'configuration'`") unless value && !value.empty?
                                                     # UI.user_error!("Couldn't find file at path '#{value}'") unless File.exist?(value)
                                                 end),
                    FastlaneCore::ConfigItem.new(key: :output_path,
                                                 env_name: 'FL_BUILD_APP_OUTPUT_PATH', # The name of the environment variable
                                                 description: 'Output_path for BuildAppAction', # a short description of this parameter
                                                 verify_block: proc do |value|
                                                     UI.user_error!("No output_path for BuildAppAction given, pass using `output_path': 'output_path'`") unless value && !value.empty?
                                                     # UI.user_error!("Couldn't find file at path '#{value}'") unless File.exist?(value)
                                                 end)
                ]
            end

            def self.output
                # Define the shared values you are going to provide
                # Example
                [
                    ['GENERATE_APP_CUSTOM_VALUE', 'A description of what this value contains']
                ]
            end

            def self.return_value
                # If you method provides a return value, you can describe here what it does
            end

            def self.authors
                # So no one will ever forget your contribution to fastlane :) You are awesome btw!
                ['Matheus Feola']
                ['Mateus de Campos']
            end

            def self.is_supported?(platform)
                # you can do things like
                #
                #  true
                #
                #  platform == :ios
                #
                #  [:ios, :mac].include?(platform)
                #

                platform == :ios
            end
        end
    end
end
