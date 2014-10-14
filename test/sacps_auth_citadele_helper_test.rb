# encoding: utf-8

require File.dirname(__FILE__) + '/test_helper'

class SacPSAuthCitadeleHelperTest < Minitest::Test
  def test_should_create_fields
    
    helper = SacPS::Auth::Citadele::Helper.new
    assert_equal true, helper.valid?
  end

end
