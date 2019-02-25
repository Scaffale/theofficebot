module TimeHelper
  def get_time(timeString)
    times = timeString.split(' --> ')
    return [times[0].split(',')[0], times[1].split(',')[0]]
  end

  def time_difference_in_seconds(minor, major)
    minorTimes = get_seconds_from_time minor
    majorTimes = get_seconds_from_time major
    return majorTimes - minorTimes
  end

  # Throws error if not time! (to safely do it use .to_i)
  def get_seconds_from_time(time)
    times = time.split(':')
    return Integer(times[0]) * 60 * 60 + Integer(times[1]) * 60 + Integer(times[2])
  end

  def is_time(timeString)
    return false if (timeString.split(' --> ')).length != 2
    begin
      time_one = get_time(timeString)[0]
      time_two = get_time(timeString)[1]
      time_difference_in_seconds(time_one, time_two)
    rescue Exception => e
      return false
    end
    return true
  end

  def is_sentence(sentence)
    if is_time(sentence)
      return false
    end
    if sentence == '' or sentence == '\n' or sentence == "\n"
      return false
    end
    if is_number?(sentence)
      return false
    end
    return true
  end

  def is_begin(sentence)
    startSentence = ['"', '-']
    return /[[:upper:]]/.match(sentence[0]) || startSentence.include?(sentence[0])
  end

  def is_end(sentence)
    endSentence = ['.', '!', '?']
    return endSentence.include?(sentence[-1])
  end

  def is_number? string
    true if Float(string) rescue false
  end

end
