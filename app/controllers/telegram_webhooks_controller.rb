class TelegramWebhooksController < Telegram::Bot::UpdatesController
  include TimeHelper
  include OptionReaderHelper

  def start!(*)
    respond_with :message, text: t('.hi')
  end

  def inline_query(query, _offset)
    who = @_update["inline_query"]["from"]
    SearchQuery.create(tid: who["id"], last_name: who["last_name"], first_name: who["first_name"], username: who["username"], query: query)
    max_results = 10
    query.strip!
    if query.blank?
      return
    end
    results = Array.new()
    parsed_query = read_options(query)

    files_srt = Dir.glob("#{Rails.root}/data/srt/*.srt")
    beforeTime = parsed_query[:before] || 1
    afterTime = parsed_query[:after] || 2
    # print "Cerco: " + parsed_query[:sentence]
    # print "Tempo Before: #{beforeTime}"
    # print "Tempo After: #{afterTime}"
    frase = parsed_query[:sentence].split(' ')
    lt_url = "http://2.224.133.78"

    finded_sentences = Sentence.where(frase.map{|e| "(lower(text) LIKE '%#{e.downcase}%')"}.join(' AND ')).limit(max_results)

    finded_sentences.each do |sentence|
      start = sentence.start_time - beforeTime
      endTs = sentence.end_time + afterTime
      new_name = "#{sentence.file_name.gsub('.srt', '')}-#{start}-#{endTs}"
      comand = "ffmpeg -ss #{start} -loglevel panic -n -i #{Rails.root}/data/srt/#{sentence.file_name.gsub '.srt', '.mp4'} -t #{endTs - start} -c copy -avoid_negative_ts 1 #{Rails.public_path}/gifs/#{new_name}.mp4"
      # comand = "ffmpeg -loglevel panic -ss #{start} -strict -2 -to #{endTs} -n -i #{Rails.root}/data/srt/#{sentence.file_name.gsub '.srt', '.mp4'} #{Rails.public_path}/gifs/#{new_name}.mp4"
      # print(comand)
      system(comand)
      # fork { exec(comand) }
      # p "#{lt_url}/gifs/#{new_name}.mp4"
      results << {
        type: :mpeg4_gif,
        id: "#{new_name}",
        mpeg4_url: "#{lt_url}/gifs/#{new_name}.mp4",
        thumb_url: "#{lt_url}/placeholder.jpg"
      }
    end
    # rispondere subito poi create le gif in thread separato ?
    answer_inline_query results
  end

end
