# # encoding: utf-8

# require File.dirname(__FILE__) + '/test_helper'

# class SacPSAuthDnbNotificationtest < Minitest::Test
#   # include Banklink

#   def setup
#     @dnb_auth = SacPS::Auth::Dnb.notification(http_raw_data)
#   end

#   def test_user_information
#     assert_equal "050505-12123;JOHN DOE", @dnb_auth.user_information
#   end

#   def test_user_name
#     assert_equal "JOHN DOE", @dnb_auth.user_name
#   end

#   def test_user_identifier
#     assert_equal "050505-12123", @dnb_auth.user_identifier
#   end

#   def test_user_language
#     assert_equal "lv", @dnb_auth.user_language
#   end

#   private
#     def http_raw_data
#       "VK_SERVICE=2001&VK_VERSION=101&VK_SND_ID=RAND&VK_REC_ID=ACC1&VK_STAMP=12345678910&VK_T_NO=123456789012&VK_PER_CODE=050505-12123&VK_PER_FNAME=JOHN&VK_PER_LNAME=DOE&VK_COM_NAME=Company&VK_TIME=20131111111111&VK_LANG=LAT"
#     end

# end
