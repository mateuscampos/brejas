module Fastlane
  module Actions
    module SharedValues
      CLEAN_ENVIRONMENT_CUSTOM_VALUE = :CLEAN_ENVIRONMENT_CUSTOM_VALUE
    end

    # To share this integration with the other fastlane users:
    # - Fork https://github.com/fastlane/fastlane/tree/master/fastlane
    # - Clone the forked repository
    # - Move this integration into lib/fastlane/actions
    # - Commit, push and submit the pull request

    class CleanEnvironmentAction < Action
      def self.run(params)
        # fastlane will take care of reading in the parameter and fetching the environment variable:
        UI.message "Cleaning environment"

        sh "xcodebuild  -sdk \"${TARGET_SDK}\" -xcconfig \"${CONFIG_FILE_PATH}\"  -configuration Release clean"
        sh "xcodebuild  -sdk \"${TARGET_SDK}\" -xcconfig \"${CONFIG_FILE_PATH}\"  -configuration Debug clean"
        sh "killall Simulator || true"
        sh "xcrun simctl erase all"

      end

      #####################################################
      # @!group Documentation
      #####################################################

      def self.description
        "This action cleans Xcode project, all simulators and closes opened simulators"
      end

      def self.details
        # Optional:
        # this is your chance to provide a more detailed description of this action
        "You can use this action to do cool things..."
      end

      def self.available_options
        # Define all options your action supports.

        # Below a few examples
        [
          FastlaneCore::ConfigItem.new(key: :api_token,
                                       env_name: "FL_CLEAN_ENVIRONMENT_API_TOKEN", # The name of the environment variable
                                       description: "API Token for CleanEnvironmentAction", # a short description of this parameter
                                       verify_block: proc do |value|
                                          UI.user_error!("No API token for CleanEnvironmentAction given, pass using `api_token: 'token'`") unless (value and not value.empty?)
                                          # UI.user_error!("Couldn't find file at path '#{value}'") unless File.exist?(value)
                                       end),
          FastlaneCore::ConfigItem.new(key: :development,
                                       env_name: "FL_CLEAN_ENVIRONMENT_DEVELOPMENT",
                                       description: "Create a development certificate instead of a distribution one",
                                       is_string: false, # true: verifies the input is a string, false: every kind of value
                                       default_value: false) # the default value if the user didn't provide one
        ]
      end

      def self.output
        # Define the shared values you are going to provide
        # Example
        [
          ['CLEAN_ENVIRONMENT_CUSTOM_VALUE', 'A description of what this value contains']
        ]
      end

      def self.return_value
        # If you method provides a return value, you can describe here what it does
      end

      def self.authors
        # So no one will ever forget your contribution to fastlane :) You are awesome btw!
        ["Mateus de Campos"]
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
