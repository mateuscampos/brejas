module Fastlane
  module Actions
    module SharedValues
      GET_VERSION_ON_PLIST_CUSTOM_VALUE = :GET_VERSION_ON_PLIST_CUSTOM_VALUE
    end

    class GetVersionOnPlistAction < Action
      def self.run(params)
        UI.message "Parameter Plist name: #{params[:plist_name]}-Info"

        # plist_name = "#{params[:plist_name]}-Info"
        plist_name = "#{params[:plist_name]}"
        result = sh "agvtool what-marketing-version -terse | grep #{plist_name} | cut -d = -f 2"
        result.to_s.strip
      end

      #####################################################
      # @!group Documentation
      #####################################################

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :plist_name,
                                       env_name: "FL_GET_REAL_VERSION_PLIST_NAME", # The name of the Plist file
                                       description: "Plist file name for GetRealVersionAction", # a short description of this parameter
                                       verify_block: proc do |value|
                                          UI.user_error!("No Plist file name for GetRealVersionAction given, pass using `plist_name: 'plist'`") unless (value and not value.empty?)
                                          # UI.user_error!("Couldn't find file at path '#{value}'") unless File.exist?(value)
                                       end)
        ]
      end

      def self.description
        "Return the app's version for a given Plist file name"
      end

      def self.details
        # Optional:
        "You can use this action to get the App's version number of one specific Plist file"
      end

      def self.return_value
        # If you method provides a return value, you can describe here what it does
      end

      def self.authors
        ["Jonas Tomaz"]
      end

      def self.is_supported?(platform)
        platform == :ios
      end
    end
  end
end
