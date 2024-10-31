class UserActionNotification < ApplicationRecord
  validates_presence_of :actor_id, :action, :user_task_id
end
