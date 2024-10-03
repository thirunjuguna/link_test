require "test_helper"

class LinkClicksControllerTest < ActionDispatch::IntegrationTest
  def setup
    LinkClick.delete_all
    @link_click1 = LinkClick.create!(url: "http://example.com", created_at: 2.days.ago)
    @link_click2 = LinkClick.create!(url: "http://example2.com", created_at: 1.day.ago)
    @link_click3 = LinkClick.create!(url: "http://example3.com", created_at: 3.days.ago)
  end

  test "should get index and fetch cached stats" do
    Rails.cache.clear

    get link_clicks_url
    assert_response :success

    assert_equal 3, assigns(:total_clicks)
    assert_equal "http://example.com", assigns(:most_clicked_url)
    assert_equal [ "http://example.com", "http://example2.com", "http://example3.com" ], assigns(:top_5_clicked_urls).pluck(:url)
  end

  test "should create a LinkClick via LinkClickTrackerJob" do
    assert_enqueued_with(job: LinkClickTrackerJob) do
      post link_clicks_url, params: { url: "http://test.com", anchor_text: "Test Link" }, headers: {
        "HTTP_REFERER" => "http://referrer.com",
        "HTTP_USER_AGENT" => "Mozilla/5.0",
        "REMOTE_ADDR" => "127.0.0.1"
      }
    end

    assert_response :ok

    job = enqueued_jobs.first
    assert_equal "http://test.com", job[:args][0]
    assert_equal "Test Link", job[:args][1]
    assert_equal "http://referrer.com", job[:args][2]
    assert_equal "Mozilla/5.0", job[:args][3]
    assert_equal "127.0.0.1", job[:args][4]
  end
end
