class Contact < ActiveRecord::BaseWithoutTable
  column :name,    :string
  column :email,   :string
  column :website, :string
  column :snow,    :string
  column :content, :text

  validates_presence_of :name
  validates_presence_of :content

  validates_format_of :website, :allow_nil => true, :if => Proc.new {|c| not c.website.blank?}, :with => /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$/ix, :message => "must be a valid url"
  validates_format_of :email, :allow_nil => false, :with => /^.+@[^\.].*\.[a-z]{2,}$/ix, :message => "must be a valid email"

  validates_inclusion_of :snow, :in => %w( cold )
end
