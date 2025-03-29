module Webhookable
  extend ActiveSupport::Concern

  included do
    after_save :omit_webhook
  end

  def omit_webhook
    payload = {
      username: user.username,
      avatar_url: user.slack_avatar_url || user.github_avatar_url,
      editor:,
      language:,
      operating_system:,
      ip_address:,
      user_seconds_today: user.heartbeats.today.duration_seconds,
      global_seconds_today: self.class.today.group(:user_id).duration_seconds.values.sum
      }.to_json

    return payload
  end
end
