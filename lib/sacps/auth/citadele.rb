require 'sacps/auth/citadele/helper'
require 'sacps/auth/citadele/notification'

module SacPS
  module Auth
    module Citadele

      mattr_accessor :return_url, :identifier, :service_url, :public_key, :private_key

      SacPS::Auth::Citadele.service_url = "https://online.citadele.lv/amai/start.htm"

      # def self.notification post
      #   Notification.new post
      # end

      # def self.helper options={}
      #   Helper.new options
      # end

    end
  end
end
