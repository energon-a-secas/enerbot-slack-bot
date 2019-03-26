require_relative '../spec_helper'

describe '#core' do
  before(:each) do
    Slack.configure do |config|
      config.token = ENV['SLACK_API_TOKEN']
    end
  end

  context 'when client is initialized' do
    it 'send message' do
      Enerbot.message(UserData, 'hola')
    end

    it 'send custom message' do
      Enerbot.message('#bot_monitoring', 'Holiwis')
    end

    it 'send image' do
      Enerbot.message(UserData, 'enerbot.png')
    end
  end
end
