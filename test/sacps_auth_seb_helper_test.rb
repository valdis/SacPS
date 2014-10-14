# encoding: utf-8

require File.dirname(__FILE__) + '/test_helper'

class SacPSAuthSebHelperTest < Minitest::Test
  def test_should_create_fields
    
    helper = SacPS::Auth::Seb.helper
    assert_equal 3, helper.form_fields.size
  end

end
