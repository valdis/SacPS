# # encoding: utf-8

# require File.dirname(__FILE__) + '/test_helper'

# class SacPSAuthSebNotificationtest < Minitest::Test
#   # include Banklink

#   def setup
#     @seb_auth = SacPS::Auth::Seb.notification(http_raw_data)
#   end

#   def test_user_information
#     assert_equal "050505-12123;JOHN DOE", @seb_auth.user_information
#   end

#   def test_user_name
#     assert_equal "JOHN DOE", @seb_auth.user_name
#   end

#   def test_user_identifier
#     assert_equal "050505-12123", @seb_auth.user_identifier
#   end

#   def test_user_language
#     assert_equal "lv", @seb_auth.user_language
#   end

#   private
#     def http_raw_data
#       "IB_SND_ID=ACC1&IB_SERVICE=0001&IB_REC_ID=AAA&IB_USER=050505-12123&IB_DATE=05.12.2003&IB_TIME=10:00:00&IB_USER_INFO=ID=050505-12123;NAME=JOHN DOE&IB_VERSION=001&IB_CRC=LyCZRncu%2F%2BOi5nwzOkI6C9UMFohN6tSl3tLFyIJyNp2lGKBrDKZ2H8b%2BadU3XalzS7MwnAj8r%2FRhLpbsGNE5ysNyM4CKkSrsVzxoXbt9%2BB1foH9Rlp9LCeoR2H774f8UcMe9RVsE%2B%2BZfrEZzzXYyR1PXDCVOShQOAxlD9pbh8nk%3D&IB_LANG=LAT"


#     end

# end
