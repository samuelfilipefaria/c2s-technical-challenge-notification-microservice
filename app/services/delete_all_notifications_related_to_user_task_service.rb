class DeleteAllNotificationsRelatedToUserTaskService
  attr_accessor :user_task_id

  def initialize(user_task_id)
    @user_task_id = user_task_id
  end

  def perform
    UserActionNotification.where(user_task_id: user_task_id).destroy_all
  end
end
