class CreateWebScrapingNotificationService
  attr_accessor :scraped_data, :result, :web_scraping_task_id

  def initialize(scraped_data, result, web_scraping_task_id)
    @scraped_data = scraped_data
    @result = result
    @web_scraping_task_id = web_scraping_task_id
  end

  def perform
    raise ArgumentError.new("Invalid arguments!") unless valid_parameters?

    WebScrapingNotification.create(
      scraped_data: scraped_data,
      result: result,
      web_scraping_task_id: web_scraping_task_id
    )
  end

  private

  def valid_parameters?
    valid_result? && valid_web_scraping_task_id?
  end

  def valid_result?
    valid_non_empty_string_parameter?(result, "result")
  end

  def valid_web_scraping_task_id?
    valid_non_negative_number_parameter?(web_scraping_task_id, "web scraping task id")
  end

  def valid_non_empty_string_parameter?(parameter, parameter_name)
    raise ArgumentError.new("Invalid #{parameter_name}!") unless parameter

    parameter.strip!
    raise ArgumentError.new("Invalid #{parameter_name}!") if parameter.empty?

    true
  end

  def valid_non_negative_number_parameter?(parameter, parameter_name)
    raise ArgumentError.new("Invalid #{parameter_name}!") unless parameter

    raise ArgumentError.new("Invalid #{parameter_name}!") if parameter.to_i < 0

    true
  end
end
