class Post < ActiveRecord::Base

  has_many :comments

  acts_as_taggable

  validates_presence_of :title,     :if => :article?
  validates_presence_of :permalink, :if => :article?
  validates_presence_of :content

  validates_uniqueness_of :permalink, :if => :article?

  validates_format_of :permalink, :with => /^[a-z,0-9,-]*$/, :if => :article?

  scope :sorted,    :order      => "created_at DESC"
  scope :scratches, :conditions => { :active => true, :note => true },  :order => "created_at DESC"
  scope :posts,     :conditions => { :active => true, :note => false }, :order => "created_at DESC"
  scope :blog,      :conditions => { :active => true },                 :order => "created_at DESC",:limit => 10
  scope :active,    :conditions => { :active => true },                 :order => "created_at DESC"
  scope :inactive,  :conditions => { :active => false },                :order => "created_at DESC"

  class << self

    def archive_table
      # Thanks to Jean-Babtiste Escoyez for showing this awesome piece of Ruby code!
      active.group_by{ |post| post.created_at.year }.inject({}) do |yearly_archive, (year, blog_posts)|
        monthly_archive = blog_posts.group_by{ |post| post.created_at.month }.inject({}) do |monthly_archive, (month, blog_posts)|
          monthly_archive.merge({month => blog_posts.size})
        end
        yearly_archive.update({year => monthly_archive})
      end
    end

    def archive(year, month)
      all :conditions => ["active = true AND EXTRACT(MONTH from created_at) = ? AND EXTRACT(YEAR from created_at) = ?", month, year], :order => "created_at DESC"
    end

  end

  def article?
    !note
  end

  def keywords
    tag_list
  end

  def count_comments
    comments.size
  end

end
