require 'test_helper'

class OptionReaderHelperTest < ActionDispatch::IntegrationTest
  include OptionReaderHelper

  test 'option reader can read -b' do
    returned_value = read_options('-b 1')
    assert_equal 1, returned_value[:before]
    
    returned_value = read_options('-b 56')
    assert_equal 56, returned_value[:before]
    
    returned_value = read_options('-b -56')
    assert_equal -56, returned_value[:before]
    
    returned_value = read_options('-b 1 abcde')
    assert_equal 1, returned_value[:before]
    
    returned_value = read_options('abcde -b 56')
    assert_equal 56, returned_value[:before]
    
    returned_value = read_options('abcde -b -56')
    assert returned_value.key?(:before)
    assert_equal returned_value[:before], -56
  end

  test 'option reader can read -a' do
    returned_value = read_options('-a 1')
    assert_equal 1, returned_value[:after]
  end

end