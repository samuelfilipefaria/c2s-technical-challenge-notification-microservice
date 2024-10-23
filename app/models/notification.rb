class Notification < ApplicationRecord
  validates_presence_of :task_description, :user_id, :operation, :task_id
end
