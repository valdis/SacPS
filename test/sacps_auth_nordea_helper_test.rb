# encoding: utf-8

require File.dirname(__FILE__) + '/test_helper'

class SacPSAuthNordeaHelperTest < Minitest::Test
  def test_should_create_fields
    
    helper = SacPS::Auth::Nordea.helper
    puts helper.form_fields
    assert_equal 12, helper.form_fields.size
  end

end
