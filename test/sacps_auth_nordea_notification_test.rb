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
      "B02K_VERS=0002&B02K_TIMESTMP=2002014110314171455&B02K_IDNBR=618644&B02K_STAMP=20141103141713056838&B02K_CUSTNAME=Doe+John&B02K_KEYVERS=0001&B02K_ALG=01&B02K_CUSTID=05050512123&B02K_CUSTTYPE=01&B02K_MAC=F788CDFAB29BEDA3D9AE3EAA73E06258"
    end

end
