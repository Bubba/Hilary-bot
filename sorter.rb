require 'slack-ruby-bot'
require 'google/cloud/language'
require 'marky_markov'

no = 0
language = Google::Cloud::Language.new
File.open('positive.txt', 'a') do |positive|
	File.open('negative.txt', 'a') do |negative|
		File.open('debate.txt').read.each_line do |line|


			document = language.document line
			annotation = document.annotate
			sentiment = annotation.sentiment.score

			positive.puts line if sentiment >= 0
			negative.puts line if sentiment < 0

			puts "#{no} done"
			no += 1
		end
	end
end
