class NotificationsController < ActionController::API
  before_action :authorize_user, except: :api_message

  def send_response(message, code)
    render json: {APIresponse: message}, status: code
  end
  
  def is_given_token_valid(given_token)
    authentication_microservice_response = HTTParty.get("http://authentication_microservice_api:5000/users/valid_token?token=#{given_token}")
    authentication_microservice_response.code == 200
  end

  def authorize_user
    send_response("Token is invalid! User not found!", 404) unless is_given_token_valid(params[:token])
  end

  def get_all_notifications
    notifications = Notification.all
    render json: notifications
  end

  def send_notification
    new_notification = Notification.new(
      task_description: params[:task_description],
      user_id: params[:token],
      operation: params[:operation],
      task_id: params[:task_id],
      scraped_data: params[:scraped_data],
    )

    if new_notification.save
      send_response("Notification created!", 201)
    else
      send_response("Error creating notification!", 500)
    end
  end

  def api_message
    render json: {message: "Olá! Este é o microserviço para NOTIFICAÇÕES"}
  end
end
