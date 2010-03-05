class RemoveActiveFromPosts < ActiveRecord::Migration
  def self.up
    remove_column :posts, :active
  end

  def self.down
    add_column :posts, :active, :boolean
  end
end
