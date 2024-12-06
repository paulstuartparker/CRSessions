class RenameSessionsToCreativeSessions < ActiveRecord::Migration[8.0]
  def change
    rename_table :sessions, :creative_sessions
  end
end
