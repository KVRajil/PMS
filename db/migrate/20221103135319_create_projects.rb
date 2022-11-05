class CreateProjects < ActiveRecord::Migration[7.0]
  def change
    create_table :projects do |t|
      t.string :title, index: { unique: true }
      t.text :description
      t.integer :user_id

      t.timestamps
    end
  end
end
