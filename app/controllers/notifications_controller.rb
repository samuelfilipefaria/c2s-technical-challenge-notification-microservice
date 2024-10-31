class NotificationsController < ActionController::API
  before_action :authorize_user, except: :api_message

  def send_response(message, code)
    render json: {APIresponse: message}, status: code
  end

  def is_given_token_valid(given_token)
    authentication_microservice_response = HTTParty.get("http://authentication_microservice_api:5000/users/get_data?token=#{given_token}")
    authentication_microservice_response.code == 200
  end

  def authorize_user
    send_response("Token is invalid! User not found!", 404) unless is_given_token_valid(params[:token])
  end

  def api_message
    send_response("Hello! This is the microservice for NOTIFICATIONS", 200)
  end

  def create_user_action_notification
    actor_id = HTTParty.get("http://authentication_microservice_api:5000/users/get_user_id?token=#{params[:token]}")["userId"]
    service = CreateUserActionNotificationService.new(actor_id, params[:user_action], params[:user_task_id])

    if service.perform
      send_response("User action notification created!", 201)
    else
      send_response("Error creating user action notification!", 500)
    end
  end

  def create_web_scraping_notification
    service = CreateWebScrapingNotificationService.new(params[:scraped_data], params[:result], params[:web_scraping_task_id])

    if service.perform
      send_response("Web scraping notification created!", 201)
    else
      send_response("Error creating web scraping notification!", 500)
    end
  end

  def get_all_notifications
    user_action_notifications = GetUserActionNotificationsService.new(params[:token]).perform
    web_scraping_notifications = GetWebScrapingNotificationsService.new(params[:token]).perform

    notifications = user_action_notifications + web_scraping_notifications
    notifications.sort_by! {|notification| notification[:created_at]}
    notifications.reverse!

    if notifications
      render json: {notifications: notifications}, status: 200
    else
      send_response("Error getting notifications!", 500)
    end
  end

  def delete_all_notifications_related_to_user_task
    service = DeleteAllNotificationsRelatedToUserTaskService.new(params[:user_task_id])

    if service.perform
      send_response("Notifications deleted!", 201)
    else
      send_response("Error deleting notifications!", 500)
    end
  end

  def delete_all_notifications_related_to_web_scraping_task
    service = DeleteAllNotificationsRelatedToWebScrapingTaskService.new(params[:web_scraping_task_id])

    if service.perform
      send_response("Notifications deleted!", 200)
    else
      send_response("Error deleting notifications!", 500)
    end
  end

  def delete_all_from_web_scraping_task
    service = CreateWebScrapingNotificationService.new(params[:scraped_data], params[:result], params[:web_scraping_task_id])

    if service.perform
      send_response("Web scraping notification created!", 201)
    else
      send_response("Error creating web scraping notification!", 500)
    end
  end
end
