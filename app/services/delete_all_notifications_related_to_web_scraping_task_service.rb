class DeleteAllNotificationsRelatedToWebScrapingTaskService
  attr_accessor :web_scraping_task_id

  def initialize(web_scraping_task_id)
    @web_scraping_task_id = web_scraping_task_id
  end

  def perform
    WebScrapingNotification.where(web_scraping_task_id: web_scraping_task_id).destroy_all
  end
end
