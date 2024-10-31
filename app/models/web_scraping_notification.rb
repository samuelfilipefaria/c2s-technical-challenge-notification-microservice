class WebScrapingNotification < ApplicationRecord
  validates_presence_of :result, :web_scraping_task_id
end
