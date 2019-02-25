module OptionReaderHelper

  def read_options(sentence)
    before_value = nil
    after_value = nil
    before_option = /(?:-b) *-?\d+/.match(sentence)
    unless before_option.nil?
      if before_option.length > 0
        before_option = before_option[0]
        new_sentence = sentence.sub! before_option, ''
        before_option.sub! '-b', ''
        before_value = before_option.to_i
      end
    end
    after_option = /(?:-a) *-?\d+/.match(sentence)
    unless after_option.nil?
      if after_option.length > 0
        after_option = after_option[0]
        new_sentence = sentence.sub! after_option, ''
        after_option.sub! '-a', ''
        after_value = after_option.to_i
      end
    end
    return {before: before_value, 
            after: after_value,
            sentence: new_sentence.strip}
  end
end