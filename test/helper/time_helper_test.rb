require 'test_helper'

class TimeHelperTest < ActionDispatch::IntegrationTest
  include TimeHelper

  test 'get_time returns array of strings' do
    assert_equal ['00:24:16', '00:24:17'], get_time('00:24:16,522 --> 00:24:17,855')
  end

  test 'time_difference_in_seconds returns integer' do
    assert_equal 0, time_difference_in_seconds('00:24:16', '00:24:16')
    assert_equal 1, time_difference_in_seconds('00:24:16', '00:24:17')
    assert_equal 61, time_difference_in_seconds('00:24:16', '00:25:17')
    assert_equal 3600, time_difference_in_seconds('00:24:16', '01:24:16')
  end

  test 'get_seconds_from_time returns integer' do
    assert_equal 0, get_seconds_from_time('00:00:00')
    assert_equal 1, get_seconds_from_time('00:00:01')
    assert_equal 16, get_seconds_from_time('00:00:16')
    assert_equal 75, get_seconds_from_time('00:01:15')
    assert_equal 1546, get_seconds_from_time('00:25:46')
    assert_equal 5146, get_seconds_from_time('01:25:46')
  end

  test 'is_time returns boolean' do
    assert is_time('00:24:16,522 --> 00:24:17,855')
    assert is_time('10:24:16,522 --> 00:24:17,855')
    assert_not is_time('10:24:16,522  00:24:17,855')
    assert_not is_time('10:24:16,522 - 00:24:17,855')
    assert_not is_time('10:24:16,522 -> 00:24:17,855')
    assert_not is_time('adsjklf;lsdkj5')
    assert_not is_time('5')
    assert_not is_time('!!:24:16,522 --> 00:24:17,855')
    assert_not is_time('10:24: --> 00:24:17,855')
    assert_not is_time('and he said --> 00:24:17,855')
  end

  test 'is_sentence returns boolean' do
    assert is_sentence('I have left Dunder-Mifflin')
    assert is_sentence('after many')
    assert is_sentence('record-breaking years,')
    assert is_sentence('and I am officially')
    assert is_sentence('on the job market.')
    assert_not is_sentence('\n')
    assert_not is_sentence("\n")
    assert_not is_sentence("00:12:05,123 --> 00:12:06,421")
    assert_not is_sentence("1")
    assert_not is_sentence("2")
    assert is_sentence("2 is my favourite choice")
  end

  test 'is_end returns boolean' do
    assert is_end('on the job market.')
    assert is_end('on the job market!')
    assert is_end('on the job market?')
    assert_not is_end('on the job market')
    assert_not is_end('on the job market,')
    assert_not is_end('on the job market;')
    assert_not is_end('on the job market:')
    assert_not is_end('on the job market"')
    assert_not is_end("on the job market'")
  end
  
  test 'is_begin returns boolean' do
    assert is_begin('On the job market.')
    assert is_begin('"On the job market!')
    assert is_begin('-On the job market?')
    assert_not is_begin('on the job market')
    assert_not is_begin('1 on the job market,')
  end
  

end