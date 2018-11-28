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
        'enerbot fuq',
        'enerbot faq',
        'enerbot info eventos',
        'enerbot info talks',
        'enerbot info tips',
        'enerbot info enerlive',
        'enerbot info institute',
        'enerbot info contest general_info',
        'enerbot info contest SDSOS',
        'enerbot info contest diseña'
      ].each do |text|
        MESSAGE = text
        AccessEval.chan(BotValue)
      end
    end
  end

  # context 'when client is not initialized' do
  #   it 'fails badly' do
  #     #TODO
  #   end
  # end
end
