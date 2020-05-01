class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.string :name,  null: false
      t.text :detail,  null: false
      t.date :deadline,  null: false
      t.integer :progress,  null: false
      t.integer :priority,  null: false

      t.timestamps
    end
  end
end
