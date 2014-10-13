# encoding: utf-8

require File.dirname(__FILE__) + '/test_helper'

class SacPSAuthCommonTest < Minitest::Test
  include SacPS::Auth::Common

  def test_should_decide_string_lenght
    assert_equal "007", func_p("ĀĒŪĪĻĶŠ")
  end

  def test_should_generate_random_string_with_correct_length
    result =  generate_random_string 50
    assert_equal 50, result.size 
  end

  # def test_should_generate_data_string
  #   assert_equal "003foo003bar003goo006tooboo00510565003LVL003dsa005Āžēīū", generate_data_string(4002, PARAMS_1002, Banklink::Swedbank.required_service_params)
  # end

end
