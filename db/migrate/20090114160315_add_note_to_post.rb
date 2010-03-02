class AddNoteToPost < ActiveRecord::Migration
  def self.up
    add_column :posts, :note, :boolean

    ActiveRecord::Base.connection().update_sql("UPDATE posts SET note = f")
  end

  def self.down
    remove_column :posts, :note
  end
end
