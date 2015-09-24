require 'sacps/auth/draugiem_id/helper'
require 'sacps/auth/draugiem_id/notification'

module SacPS
  module Auth
    module DraugiemId
      mattr_accessor :app_id, :return_url

      def self.set_default_values
        # SacPS::Auth::DraugiemId.app_id ||= "1"
      end

      def self.validate_config!
        self.set_default_values
        message = []
        message << "No app_id!" if SacPS::Auth::DraugiemId.app_id.blank?
        message << "No return_url!" if SacPS::Auth::DraugiemId.return_url.blank?

        raise "DraugiemId init contains blank values, review README. Errors:\n#{message.join("\n")}" if message.any?
      end

      def self.helper
        Helper.new
      end

    end
  end
end
