class CreateLinkClicks < ActiveRecord::Migration[8.0]
  def change
    create_table :link_clicks do |t|
      t.string :url, null: false
      t.string :anchor_text
      t.string :referrer
      t.string :user_agent
      t.string :ip_address
      t.timestamps
    end

    add_index :link_clicks, :url
    add_index :link_clicks, :created_at
  end
end
