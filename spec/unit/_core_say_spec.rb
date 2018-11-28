require_relative '../spec_helper'

describe '#bot' do
  before(:each) do
    Slack.configure do |config|
      config.token = ENV['SLACK_API_TOKEN']
    end
  end

  context 'when client is initialized' do
    it 'send messages to #bots' do
      [
        'enersay #bots hola',
        'enersay #bots enerbot hola',
        'enersay #bots !·%%',
        'enersay #bots 123 123 test testing  testeando',
        'enersay #bots testing:energon:',
        'enersay #bots :energon::energon::energon:',
        'enersay #bots :newalert: testing :energon:'
      ].each do |text|
        MESSAGE = text
        AccessEval.say(BotValue)
      end
    end
  end

  # context 'when client is not initialized' do
  #   it 'fails badly' do
  #     #TODO
  #   end
  # end
end
