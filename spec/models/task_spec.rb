# spec/models/task_spec.rb
require 'rails_helper'

RSpec.describe Task, type: :model do
  let(:task) { build(:task) }

  describe 'callbacks' do
    it 'triggers notify_if_urgent after save' do
      expect(task).to receive(:notify_if_urgent)
      task.save
    end
  end

  describe '#notify_if_urgent' do
    it 'enqueues SendSmsJob when title includes urgent' do
      task.title = "urgent task"
      expect {
        task.save
      }.to have_enqueued_job(SendSmsJob).with(Rails.application.credentials.dig(:notification_phone_number), "An urgent task has been created: urgent task")
    end

    it 'does not enqueue SendSmsJob when title does not include urgent' do
      task.title = "normal task"
      expect {
        task.save
      }.not_to have_enqueued_job(SendSmsJob)
    end
  end
end
