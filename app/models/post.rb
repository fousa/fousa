class Post < ActiveRecord::Base

  has_many :comments

  acts_as_taggable

  validates_presence_of :title,     :if => :article?
  validates_presence_of :permalink, :if => :article?
  validates_presence_of :content

  validates_uniqueness_of :permalink, :if => :article?

  validates_format_of :permalink, :with => /^[a-z,0-9,-]*$/, :if => :article?

  named_scope :sorted,    :order      => "created_at DESC"
  named_scope :scratches, :conditions => { :active => true, :note => true },  :order => "created_at DESC"
  named_scope :posts,     :conditions => { :active => true, :note => false }, :order => "created_at DESC"
  named_scope :blog,      :conditions => { :active => true },                 :order => "created_at DESC",:limit => 10
  named_scope :active,    :conditions => { :active => true },                 :order => "created_at DESC"
  named_scope :inactive,  :conditions => { :active => false },                :order => "created_at DESC"

  def article?
    !note
  end

  def keywords
    tag_list.map
  end

  def count_comments
    comments.size
  end

  def self.count_archive
    years = posts.map(&:created_at).map(&:year).uniq.sort {|x,y| y <=> x }
    years_hash = Hash.new
    years.each do |year|
      months_hash = Hash.new
      %w(01 02 03 04 05 06 07 08 09 10 11 12).each do |month|
        months_hash[month] = count(:all, :conditions => ["active = true AND EXTRACT(MONTH from created_at) = ? AND EXTRACT(YEAR from created_at) = ?", month, year])
      end
      years_hash[year] = months_hash
    end
    years_hash
  end

  def self.archive(year, month)
    all :conditions => ["active = true AND EXTRACT(MONTH from created_at) = ? AND EXTRACT(YEAR from created_at) = ?", month, year], :order => "created_at DESC"
  end
end
