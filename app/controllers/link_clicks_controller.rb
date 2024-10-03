class LinkClicksController < ApplicationController
  protect_from_forgery with: :null_session, only: [ :create ]
  def index
    @total_clicks = Rails.cache.fetch("total_clicks", expires_in: 10.minutes) do
      LinkClick.count
    end
    @most_clicked_url = Rails.cache.fetch("most_clicked_url", expires_in: 10.minutes) do
      LinkClick.most_clicked_url
    end
    @least_clicked_url = Rails.cache.fetch("least_clicked_url", expires_in: 10.minutes) do
      LinkClick.least_clicked_url
    end
    @top_5_clicked_urls = Rails.cache.fetch("top_5_clicked_urls", expires_in: 10.minutes) do
      LinkClick.top_5_clicked_urls
    end
  end

 def create
  LinkClickTrackerJob.perform_later(
    link_clicks_params[:url],
    link_clicks_params[:anchor_text],
    referrer,
    user_agent,
    ip_address
  )

  head :ok
 end

 private

 def link_clicks_params
  params.permit(:url, :anchor_text)
 end
end
