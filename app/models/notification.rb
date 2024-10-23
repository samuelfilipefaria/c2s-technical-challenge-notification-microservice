class Notification < ApplicationRecord
  validates_presence_of :task_description, :user_id, :opearation, :task_id
end
