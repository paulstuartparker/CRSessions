class AddRecurringToSessions < ActiveRecord::Migration[8.0]
  def change
    add_column :sessions, :recurring, :boolean
    remove_column :sessions, :recurrence_rule
    add_column :sessions, :recurrence_rule, :integer
  end
end
