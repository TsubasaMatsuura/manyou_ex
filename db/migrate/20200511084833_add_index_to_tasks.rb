class AddIndexToTasks < ActiveRecord::Migration[5.2]
  def change
  	add_index :tasks, [:name, :progress]
  end
end
