class AddNoteToPost < ActiveRecord::Migration
  def self.up
    add_column :posts, :note, :boolean
    Post.update_attribute(:note, false)
  end

  def self.down
    remove_column :posts, :note
  end
end
