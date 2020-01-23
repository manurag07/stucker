# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :user
  validates :content, length: { in: 10..140 }
  validates :scheduled_at, presence: true
  after_create :schedule
  # validates_datetime :scheduled_at, on: :create, on_or_after: Time.zone.now

  def to_twitter
    client = Twitter::REST::Client.new do |config|
      config.access_token        = user.twitter.oauth_token
      config.access_token_secret = user.twitter.secret
      config.consumer_key        = ENV['TWITTER_KEY']
      config.consumer_secret     = ENV['TWITTER_SECRET']
    end
    client.update(content)
  end

  def display
    unless state == 'cancel'
      to_twitter if twitter == true
      update_attributes(state: 'posted')
    end
  rescue StandardError => e
    update_attributes(state: 'posting error', error: e.message)
  end

  def schedule
    ScheduleJob.set(wait_until: scheduled_at).perform_later(self)
    update_attributes(state: 'scheduled')
  rescue StandardError => e
    update_attributes(state: 'scheduling error', error: e.message)
  end
end
