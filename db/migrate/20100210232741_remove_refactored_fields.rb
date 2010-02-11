class RemoveRefactoredFields < ActiveRecord::Migration
  def self.up
    remove_column :comments, :spam
    drop_table :simple_captcha_data
  end

  def self.down
    create_table :simple_captcha_data do |t|
      t.string :key, :limit => 40
      t.string :value, :limit => 6
      t.timestamps
    end
    add_column :comments, :spam, :boolean
  end
end
