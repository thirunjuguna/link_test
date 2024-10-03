require "test_helper"

class LinkClickTest < ActiveSupport::TestCase
  def setup
    @link_click1 = LinkClick.create!(url: "http://example.com", created_at: 2.days.ago)
    @link_click2 = LinkClick.create!(url: "http://example.com", created_at: 1.day.ago)
    @link_click2 = LinkClick.create!(url: "http://example.com", created_at: 1.day.ago)
    @link_click4 = LinkClick.create!(url: "http://example2.com", created_at: 5.days.ago)
    @link_click5 = LinkClick.create!(url: "http://example2.com", created_at: 4.days.ago)
    @link_click6 = LinkClick.create!(url: "http://example3.com", created_at: 1.hour.ago)
    @link_click6 = LinkClick.create!(url: "'http://google.com1", created_at: 1.hour.ago)
    @link_click6 = LinkClick.create!(url: "'http://google.com1", created_at: 1.hour.ago)
    @link_click6 = LinkClick.create!(url: "'http://google.com", created_at: 1.hour.ago)
    @link_click6 = LinkClick.create!(url: "'http://google.com", created_at: 1.hour.ago)
  end

  test "should validate presence of url" do
    link_click = LinkClick.new
    assert_not link_click.save, "Saved the LinkClick without a url"
    assert_includes link_click.errors[:url], "can't be blank"
  end

  test "most_clicked_url scope returns the most clicked URL" do
    most_clicked = LinkClick.most_clicked_url
    assert_equal "http://example.com", most_clicked
  end

  test "least_clicked_url scope returns the least clicked URL" do
    least_clicked = LinkClick.least_clicked_url
    assert_equal "http://example3.com", least_clicked
  end

  test "top_5_clicked_urls scope returns the top 5 clicked URLs" do
    top_5 = LinkClick.top_5_clicked_urls.pluck(:url)
    assert_equal [ "http://example.com",
    "'http://google.com",
    "'http://google.com1",
    "http://example2.com",
    "http://example3.com" ],  top_5
  end
end
