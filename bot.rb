require 'slack-ruby-bot'
require 'google/cloud/language'
require 'marky_markov'

class Bot < SlackRubyBot::Bot

	language = Google::Cloud::Language.new
	positiveMarkov = MarkyMarkov::TemporaryDictionary.new
	negativeMarkov = MarkyMarkov::TemporaryDictionary.new	
	positiveMarkov.parse_file 'positive.txt'
	negativeMarkov.parse_file 'negative.txt'

	match /^*$/ do |client, data, match|
		if data.subtype != "bot_message" then
			sleep 5

			messageDocument = language.document data.text

			messageAnnotation = messageDocument.annotate

			messageEntity = messageAnnotation.entities.first
			messageSentiment = messageAnnotation.sentiment.score

			template = messageSentiment >= 0 ? positiveMarkov.generate_n_sentences(1) : negativeMarkov.generate_n_sentences(2)

			templateDocument = language.document template
			templateAnnotation = templateDocument.annotate

			templateEntity = templateAnnotation.entities.first

			puts "#{messageSentiment >= 0 ? "Positively" : "Negatively"} replying to #{data.text} with #{template}"

			if messageEntity != nil and templateEntity != nil then
				reply = template.sub templateEntity.name, messageEntity.name
			else
				reply = template
			end

			puts reply

			client.say(text: reply, channel: data.channel, gif: 'hillary')
		end
	end
end

SlackRubyBot::Client.logger.level = Logger::WARN
Bot.run
