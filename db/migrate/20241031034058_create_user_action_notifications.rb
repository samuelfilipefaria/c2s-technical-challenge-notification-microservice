class CreateUserActionNotifications < ActiveRecord::Migration[7.2]
  def change
    create_table :user_action_notifications do |t|
      t.integer :actor_id
      t.string :action
      t.integer :user_task_id

      t.timestamps
    end
  end
end
