# spec/services/sms_sender_spec.rb
require 'rails_helper'

RSpec.describe SmsSender, type: :service do
  let(:message) { "Test Message" }
  let(:phone_number) { Rails.application.credentials.dig(:notification_phone_number) }

  it 'sends an SMS via Twilio' do
    client = double('Twilio::REST::Client')
    messages = double('Twilio::REST::Api::V2010::AccountContext::MessageList')
    allow(Twilio::REST::Client).to receive(:new).and_return(client)
    allow(client).to receive(:messages).and_return(messages)
    allow(messages).to receive(:create)

    SmsSender.send_sms(phone_number, message)

    expect(messages).to have_received(:create).with(
      from: Rails.application.credentials.dig(:twilio, :phone_number),
      to: phone_number,
      body: message
    )
  end
end
