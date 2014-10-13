# encoding: utf-8

require File.dirname(__FILE__) + '/test_helper'

class SacPSAuthCitadeleHelperTest < Minitest::Test
  def test_should_create_fields
    
    options = {}
    options[:return] = 'http://myplace/'

    helper = SacPS::Auth::Citadele::Helper.new('ACC1', options)
    assert_equal 9, helper.form_fields.size
  end

end
