# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
include TimeHelper

Sentence.delete_all

currentSentence = ""
startTime = ''
endTime = ''
current_filename = ''
season = 0
episode = 0
Dir.glob("#{Rails.root}/data/srt/*.srt").each do |file|
  # Ultima frase del file precente
  if currentSentence != ""
    start = get_seconds_from_time(startTime)
    endTs = get_seconds_from_time(endTime)
    Sentence.create!(season: season, 
                     episode: episode, 
                     file_name: current_filename, 
                     end_time: endTs, 
                     start_time: start,
                     text: currentSentence)
    currentSentence = ''
  end
  current_filename = file.split('/')[-1]
  season = current_filename.split('E')[0].split('S')[1].to_i
  episode = current_filename.split('_')[0].split('E')[1].to_i
  print "Analizzo " + file
  openedFile = open(file).readlines()
  is_not_ended = true
  openedFile.each_with_index do |line, index|
    line = line.strip
    if is_sentence(line)
      if is_begin(line) && is_not_ended
        is_not_ended = false
        currentSentence = line
        # startTime
        i = -1
        while !is_time(openedFile[index + i].strip) do
          i -= 1
        end
        startTime = get_time(openedFile[index + i].strip)[0]
      else
        currentSentence += " #{line}"
      end
      # endTime
      i = -1
      while !is_time(openedFile[index + i].strip) do
        i -= 1
      end
      endTime = get_time(openedFile[index + i].strip)[1]
      if is_end(line)
        is_not_ended = true
        start = get_seconds_from_time(startTime)
        endTs = get_seconds_from_time(endTime)
        Sentence.create!(season: season, 
                         episode: episode, 
                         file_name: current_filename, 
                         end_time: endTs, 
                         start_time: start,
                         text: currentSentence)
        currentSentence = ''
      end
    end
  end
end