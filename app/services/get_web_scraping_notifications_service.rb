class GetWebScrapingNotificationsService
  attr_accessor :token

  def initialize(token)
    @token = token
  end

  def perform
    all_web_scraping_notifications = WebScrapingNotification.all
    formatted_web_scraping_notifications = []

    all_web_scraping_notifications.each do |web_scraping_notification|
      scraped_url = HTTParty.get("http://main_task_system_api:3000/web_scraping_tasks/get_a_task?token=#{token}&web_scraping_task_id=#{web_scraping_notification.web_scraping_task_id}")["task"]["url_for_scraping"]
      
      if (web_scraping_notification.result != "failed")
        formatted_web_scraping_notification = "The data: #{web_scraping_notification.scraped_data} was scraped from #{scraped_url}"
      else
        formatted_web_scraping_notification = "The scraping on '#{scraped_url}' failed!"
      end

      formatted_web_scraping_notifications << {:notification_text => formatted_web_scraping_notification, :created_at => web_scraping_notification.created_at}
    end

    formatted_web_scraping_notifications
  end
end
