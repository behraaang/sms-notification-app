# spec/factories/tasks.rb
FactoryBot.define do
    factory :task do
      title { "Test Task" }
      status { "incomplete" }
    end
  end