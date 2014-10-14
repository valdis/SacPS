# encoding: utf-8

require File.dirname(__FILE__) + '/test_helper'

class SacPSAuthSwedbankHelperTest < Minitest::Test
  def test_should_create_fields
    
    helper = SacPS::Auth::Swedbank::Helper.new
    assert_equal 8, helper.form_fields.size
  end

end
