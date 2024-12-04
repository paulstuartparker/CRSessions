class CreateSessions < ActiveRecord::Migration[8.0]
  def change
    create_table :sessions do |t|
      t.string :title, null: false
      t.string :style, null: false
      t.text :notes
      t.datetime :start_time, null: false
      t.datetime :end_time, null: false
      t.string :recurrence_rule
      t.references :location, null: false, foreign_key: true

      t.timestamps
    end

    add_index :sessions, :start_time
    add_index :sessions, :style
  end
end
