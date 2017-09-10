# Hilary-bot
An automated Slack bot designed to debate against https://github.com/414owen/TrumpBot

It starts with a large sample of Hilary Clinton's transcribed speeches.
The sentences from the speeches are then sorted with `sorter.rb` into negative and positive sentences using Google's natural language processing APIs.
It utilises the sentiment of the sentence to determine wether it is negative or positive.

`bot.rb` will then listen out for messages coming in on Slack.
When it gets a message it checks it sentiment, and generates a response using a Markov chain trained on either the positive or negative sentences.
It will then pick out the entity or 'subject' of the incoming message, and swap out the response's entity with the message's entity, so that the debate remains relatively on-topic.

![Screenshot](/IMG_0395.PNG?raw=true "Screenshot of the carnage")
