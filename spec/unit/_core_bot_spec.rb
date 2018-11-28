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
        'enerbot hola',
        'enerbot pregunta',
        'enerbot como estas',
        'enerbot beneficio',
        'enerbot pack',
        'enerbot rules',
        'enerbot cuándo pagan',
        'enerbot cuanto para el 18',
        'enerbot password',
        'enerbot password sec',
        'enerbot 2fa asadasd',
        'enerbot random 1 2 3',
        'enerbot horoscopo piscis',
        'enerbot resultados kino',
        'enerbot dame numeros para el kino',
        'enerbot valor accion energon',
        'enerbot qr hola',
        'enerbot vuelo LAN122',
        'enerbot clima'
      ].each do |text|
        MESSAGE = text
        AccessEval.chan(BotValue)
      end
    end

    it 'send credit cards to #bots' do
      [
        'enerbot tc bankcard',
        'enerbot tc masterca'
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
