# app/jobs/send_sms_job.rb
class SendSmsJob < ApplicationJob
    queue_as :default
  
    def perform(phone_number, message)
        SmsSender.send_sms(phone_number, message)
    end
  end