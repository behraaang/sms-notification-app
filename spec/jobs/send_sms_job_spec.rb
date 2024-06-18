# spec/jobs/send_sms_job_spec.rb
require 'rails_helper'

RSpec.describe SendSmsJob, type: :job do
  let(:message) { "Test Message" }
  let(:phone_number) { Rails.application.credentials.dig(:notification_phone_number) }

  it 'calls SmsSender.send_sms with correct parameters' do
    expect(SmsSender).to receive(:send_sms).with(phone_number, message)
    SendSmsJob.perform_now(phone_number, message)
  end
end
