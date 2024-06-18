# config/routes.rb
Rails.application.routes.draw do
  # config/routes.rb
  require 'sidekiq/web'

  Sidekiq::Web.use Rack::Auth::Basic do |username, password|
    ActiveSupport::SecurityUtils.secure_compare(::Digest::SHA256.hexdigest(username), ::Digest::SHA256.hexdigest(Rails.application.credentials.dig(:sidekiq, :username))) &
      ActiveSupport::SecurityUtils.secure_compare(::Digest::SHA256.hexdigest(password), ::Digest::SHA256.hexdigest(Rails.application.credentials.dig(:sidekiq, :password)))
  end
  
  Rails.application.routes.draw do
    mount Sidekiq::Web => '/sidekiq'
    # Other routes...
  end

  resources :tasks, only: [:index, :create, :update]
end