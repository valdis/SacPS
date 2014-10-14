# encoding: utf-8

require File.dirname(__FILE__) + '/test_helper'

class SacPSAuthDnbNotificationtest < Minitest::Test
  # include Banklink

  def setup
    @dnb = SacPS::Auth::Dnb.notification(http_raw_data)
  end

  def test_accessors
    assert_equal "PERSON:050505-12123;NAME:JOHN DOE", @dnb.user_information
    assert_equal "lv", @dnb.language
  end

  private
    def http_raw_data
      "VK_SERVICE=2001&VK_VERSION=101&VK_SND_ID=RAND&VK_REC_ID=ACC1&VK_STAMP=12345678910&VK_T_NO=123456789012&VK_PER_CODE=050505-12123&VK_PER_FNAME=JOHN&VK_PER_LNAME=DOE&VK_COM_NAME=Company&VK_TIME=20131111111111&VK_LANG=LAT"
    end

end
