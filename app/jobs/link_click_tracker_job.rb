class LinkClickTrackerJob < ApplicationJob
  def perform(url, anchor_text, referrer, user_agent, ip_address)
    LinkClick.create!(
      url:,
      anchor_text:,
      referrer:,
      user_agent:,
      ip_address:
    )
  end
end
