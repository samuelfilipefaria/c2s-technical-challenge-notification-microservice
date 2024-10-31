class GetUserActionNotificationsService
  attr_accessor :token

  def initialize(token)
    @token = token
  end

  def perform
    all_user_action_notifications = UserActionNotification.all
    formatted_user_action_notifications = []

    all_user_action_notifications.each do |user_action_notification|
      actor_name = HTTParty.get("http://authentication_microservice_api:5000/users/get_data_by_id?token=#{token}&user_id=#{user_action_notification.actor_id}")["name"]
      user_task = HTTParty.get("http://main_task_system_api:3000/user_tasks/get_a_task?token=#{token}&user_task_id=#{user_action_notification.user_task_id}")["task"]
      user_task_description = user_task["description"]
      user_task_id = user_task["id"]

      formatted_user_action_notification = "#{actor_name ? "The user '#{actor_name}'" : "A deleted user"} #{user_action_notification.action} the task '##{user_task_id}  #{user_task_description}'"

      formatted_user_action_notifications << {:notification_text => formatted_user_action_notification, :created_at => user_action_notification.created_at}
    end

    formatted_user_action_notifications
  end
end
