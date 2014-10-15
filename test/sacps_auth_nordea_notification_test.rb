# encoding: utf-8

require File.dirname(__FILE__) + '/test_helper'

class SacPSAuthNordeaNotificationtest < Minitest::Test
  def setup
    @nordea_auth = SacPS::Auth::Nordea.notification(http_raw_data)
  end

  def test_user_information
    assert_equal "050505-12123;JOHN DOE", @nordea_auth.user_information
  end

  def test_user_name
    assert_equal "JOHN DOE", @nordea_auth.user_name
  end

  def test_user_identifier
    assert_equal "050505-12123", @nordea_auth.user_identifier
  end

  private
    def http_raw_data
      "B02K_VERS=0002&B02K_TIMESTAMP=20141015114103717334&B02K_IDNBR=87441733816&B02K_STAMP=20141015113959182431&B02K_CUSTNAME=JOHN DOE&B02K_KEYVERS=0001&B02K_ALG=02&B02K_CUSTID=05050512123&B02K_CUSTTYPE=02&B02K_MAC=A29C7849106F7C35B057CE27AF3C5ACA"
    end

end
