module Fastlane
  module Actions
    module SharedValues
      GET_REMOTE_TAG_CUSTOM_VALUE = :GET_REMOTE_TAG_CUSTOM_VALUE
    end

    # To share this integration with the other fastlane users:
    # - Fork https://github.com/fastlane/fastlane/tree/master/fastlane
    # - Clone the forked repository
    # - Move this integration into lib/fastlane/actions
    # - Commit, push and submit the pull request

    class GetRemoteTagAction < Action
      def self.run(params)
        # fastlane will take care of reading in the parameter and fetching the environment variable:
        UI.message "Parameter API Token: #{params[:scheme]}"

        result = sh "git tag | egrep #{params[:scheme]} | cut -d '_' -f 3 | cut -d 'b' -f 2 | sort -n | tail -n 1"
        #result = sh "git tag | egrep #{params[:scheme]} | awk -F "_" '{print $3}' | awk -F "b" '{print $2}' | sort -n | tail -n 1"
        #result = sh "git tag | egrep #{params[:scheme]} | sort | tail -n 1 | cut -d '_' -f 3 | cut -b 2-"
        puts "THE RESULT IS #{result.strip.to_i}"
        result.strip.to_i
      end

      #####################################################
      # @!group Documentation
      #####################################################

      def self.description
        "A short description with <= 80 characters of what this action does"
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
          FastlaneCore::ConfigItem.new(key: :scheme,
                                       env_name: "FL_GET_REMOTE_TAG_SCHEME",
                                       description: "SCHEME for GetRemoteTagAction",
                                       verify_block: proc do |value|
                                          UI.user_error!("No SCHEME for GetRemoteTagAction given, pass using `scheme: 'scheme'`") unless (value and not value.empty?)
                                       end)
        ]
      end

      def self.output
        # Define the shared values you are going to provide
        # Example
        [
          ['GET_REMOTE_TAG_CUSTOM_VALUE', 'A description of what this value contains']
        ]
      end

      def self.return_value
        # If you method provides a return value, you can describe here what it does
      end

      def self.authors
        # So no one will ever forget your contribution to fastlane :) You are awesome btw!
        ["Your GitHub/Twitter Name"]
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
