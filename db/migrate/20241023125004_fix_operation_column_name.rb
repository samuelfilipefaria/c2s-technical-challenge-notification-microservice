class FixOperationColumnName < ActiveRecord::Migration[7.2]
  def change
    change_table :notifications do |t|
      t.rename :opearation, :operation
    end
  end
end
