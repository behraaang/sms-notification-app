# app/services/sms_sender.rb
class SmsSender
    def self.send_sms(to, message)
      client = Twilio::REST::Client.new
      client.messages.create(
        from: Rails.application.credentials.dig(:twilio, :phone_number),
        to: to,
        body: message
      )
    end
  end