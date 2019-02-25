module OptionReaderHelper

  def read_options(sentence)
    before_value = nil
    after_value = nil
    season_value = nil
    episode_value = nil
    before_option = /(?:-b) *-?\d+/.match(sentence)
    new_sentence = sentence
    unless before_option.nil?
      if before_option.length > 0
        before_option = before_option[0]
        new_sentence = new_sentence.sub! before_option, ''
        before_option.sub! '-b', ''
        before_value = before_option.to_i
      end
    end
    after_option = /(?:-a) *-?\d+/.match(new_sentence)
    unless after_option.nil?
      if after_option.length > 0
        after_option = after_option[0]
        new_sentence = new_sentence.sub! after_option, ''
        after_option.sub! '-a', ''
        after_value = after_option.to_i
      end
    end
    season_option = /(?:-s) *\d+/.match(new_sentence)
    unless season_option.nil?
      if season_option.length > 0
        season_option = season_option[0]
        new_sentence = new_sentence.sub! season_option, ''
        season_option.sub! '-s', ''
        season_value = season_option.to_i
      end
    end
    episode_option = /(?:-e) *\d+/.match(new_sentence)
    unless episode_option.nil?
      if episode_option.length > 0
        episode_option = episode_option[0]
        new_sentence = new_sentence.sub! episode_option, ''
        episode_option.sub! '-e', ''
        episode_value = episode_option.to_i
      end
    end
    return {before: before_value, 
            after: after_value,
            season: season_value,
            episode: episode_value,
            sentence: new_sentence.strip}
  end
end