require_relative '../spec_helper'

describe 'case functions' do
  before(:each) do
    Slack.configure do |config|
      config.token = ENV['SLACK_API_TOKEN']
    end
  end

  context 'when bot receive data' do
    # TODO
    it 'does nothing' do
      UserData.message('enerbot cuando pagan?')
      Case.bot(UserData)
    end

    it 'return a quote' do
      UserData.message('enershut')
      Case.bot(UserData)
    end

    it 'send attachment' do
      UserData.message('enerbot faq')
      Case.events(UserData)
    end
  end
end
