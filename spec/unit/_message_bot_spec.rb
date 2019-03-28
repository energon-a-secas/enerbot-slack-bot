require_relative '../spec_helper'

describe '#core' do
  before(:each) do
    Slack.configure do |config|
      config.token = ENV['SLACK_API_TOKEN']
    end
  end

  context 'when bot receive data' do
    it 'send message' do
      EnerCore.send(UserData, 'hola')
    end

    it 'send custom message' do
      EnerCore.send('#bot_monitoring', 'Holiwis')
    end

    it 'send image' do
      EnerCore.send(UserData, 'enerbot.png')
    end
  end
end
