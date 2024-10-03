require "test_helper"

class LinkClickTrackerJobTest < ActiveJob::TestCase
  def setup
    @url = "http://example.com"
    @anchor_text = "Example Link"
    @referrer = "http://referrer.com"
    @user_agent = "Mozilla/5.0"
    @ip_address = "127.0.0.1"
  end

  test "LinkClickTrackerJob should create a LinkClick record" do
    assert_difference("LinkClick.count", 1) do
      LinkClickTrackerJob.perform_now(@url, @anchor_text, @referrer, @user_agent, @ip_address)
    end

    link_click = LinkClick.last
    assert_equal @url, link_click.url
    assert_equal @anchor_text, link_click.anchor_text
    assert_equal @referrer, link_click.referrer
    assert_equal @user_agent, link_click.user_agent
    assert_equal @ip_address, link_click.ip_address
  end
end
