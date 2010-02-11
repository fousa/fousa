class AddPersonalToComment < ActiveRecord::Migration
  def self.up
    add_column :comments, :personal_comment, :boolean
  end

  def self.down
    remove_column :comments, :personal_comment
  end
end
