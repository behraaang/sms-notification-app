# app/models/task.rb
class Task < ApplicationRecord
    after_save :notify_if_urgent
  
    private
  
    def notify_if_urgent
      if saved_change_to_title? && title.include?('urgent')
        SendSmsJob.perform_later(
          Rails.application.credentials.dig(:notification_phone_number),
          "An urgent task has been created: #{title}"
        )
      end
    end
  end