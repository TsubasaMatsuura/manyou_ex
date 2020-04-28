class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.string :name
      t.text :detail
      t.date :deadline
      t.integer :progress
      t.integer :priority

      t.timestamps
    end
  end
end
