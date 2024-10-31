class CreateWebScrapingNotifications < ActiveRecord::Migration[7.2]
  def change
    create_table :web_scraping_notifications do |t|
      t.string :scraped_data
      t.string :result
      t.integer :web_scraping_task_id

      t.timestamps
    end
  end
end
