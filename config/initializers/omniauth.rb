# frozen_string_literal: true

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, ENV['TWITTER_KEY'], ENV['TWITTER_SECRET']
  provider :facebook, ENV['FACEBOOK_ID'], ENV['FACEBOOK_SECRET'], scope: 'email,publish_actions'
end

OmniAuth.config.on_failure = proc do |env|
  ConnectionsController.action(:omniauth_failure).call(env)
  # this will invoke the omniauth_failure action in UsersController.
end
