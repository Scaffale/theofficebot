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
    assert_equal -100, read_options('-a -100')[:after]
    assert_equal 0, read_options('-a 0')[:after]
  end

  test 'option reader can read -s' do
    returned_value = read_options('-s 1')
    assert_equal 1, returned_value[:season]
    assert_equal 100, read_options('-s 100')[:season]
    assert_equal 0, read_options('-s 0')[:season]
  end
  
  test 'option reader can read -e' do
    returned_value = read_options('-e 1')
    assert_equal 1, returned_value[:episode]
    assert_equal 100, read_options('-e 100')[:episode]
    assert_equal 0, read_options('-e 0')[:episode]
  end

  test 'option reads and remove options to divide them into object' do
    value = {before: 1,
            after: 2,
            season: nil,
            episode: nil,
            sentence: 'that what she said'}
    assert_equal value, read_options('that what she said -b 1 -a 2')
    value = {before: nil,
            after: nil,
            season: nil,
            episode: nil,
            sentence: 'i'}
    assert_equal value, read_options('i')
  end

end