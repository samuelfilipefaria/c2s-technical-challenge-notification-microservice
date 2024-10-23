class CreateNotifications < ActiveRecord::Migration[7.2]
  def change
    create_table :notifications do |t|
      t.string :task_description
      t.string :user_id
      t.string :opearation
      t.string :task_id
      t.string :scraped_data

      t.timestamps
    end
  end
end
