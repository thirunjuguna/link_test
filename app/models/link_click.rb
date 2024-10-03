class LinkClick < ApplicationRecord
  validates :url, presence: true

  scope :most_clicked_url, -> {
    group(:url)
    .order(Arel.sql("COUNT(url) DESC"))
    .limit(1)
    .pluck(:url)
    .first
  }

  scope :least_clicked_url, -> {
    group(:url).order("COUNT(url) ASC").limit(1).pluck(:url).first
  }

  scope :top_5_clicked_urls, -> {
    subquery = select(:url, "COUNT(url) AS clicks_count", "MAX(created_at) AS last_clicked")
                 .group(:url)

    from(subquery, :link_clicks)
      .order(Arel.sql("clicks_count DESC"))
      .limit(5)
  }
end
