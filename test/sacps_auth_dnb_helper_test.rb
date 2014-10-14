# encoding: utf-8

require File.dirname(__FILE__) + '/test_helper'

class SacPSAuthDnbHelperTest < Minitest::Test
  def test_should_create_fields
    
    helper = SacPS::Auth::Dnb.helper
    assert_equal 7, helper.form_fields.size
  end

end
