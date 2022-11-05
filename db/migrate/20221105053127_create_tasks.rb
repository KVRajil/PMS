class CreateTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks do |t|
      t.string  :title
      t.string  :description
      t.integer :project_id,  index: true
      t.integer :reporter_id, index: true
      t.integer :assignee_id, index: true
      t.string  :status, index: true
      t.date    :start_date
      t.date    :end_date

      t.timestamps
    end
    add_index :tasks, %i[title project_id], unique: true
  end
end
