## SMS Notification App 

this app is using rails, twilio for messaging, sidekiq for background job, rspec for testing

### install instructions

* clone the repositiory
* run `bundle install`
* run `rails db:create db:migrate`
* run `EDITOR="nano" bin/rails credentials:edit` and set you app credentials as following structure:

twilio:
  account_sid: 'your_acount_sid'
  auth_token: 'your_account_auth_token'
  phone_number: 'your_twilio_phone_number'
notification_phone_number: 'your_recepient_number'
sidekiq:
  username: 'sidekiq_username'
  password: 'sidekiq_password'

* you can run the test suite with `bundle exec rspec`
* run a server in a separate terminal with `rails s`: that will run the backend api on localhost:3000
* cd into frontend folder and run `yarn dev`: that will run the frontend server on localhost:3001
* run a sidekiq runner in a separate terminal with `bundle exec sidekiq`
* head to localhost:3001 on your browser
* try a message containing the letter urgent
