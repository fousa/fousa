class ChangeTaggingImplementation < ActiveRecord::Migration
  def self.up
    add_column :taggings, :tagger_id,   :integer
    add_column :taggings, :tagger_type, :string
    add_column :taggings, :context,     :string

    add_index :taggings, :context

    ActiveRecord::Base.connection().update_sql("UPDATE taggings SET context = 'tags'")
  end

  def self.down
    remove_index :taggings, :context

    remove_column :taggings, :tagger_id
    remove_column :taggings, :tagger_type
    remove_column :taggings, :context
  end
end
