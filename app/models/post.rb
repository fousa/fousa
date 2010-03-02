class Post < ActiveRecord::Base

  has_many :comments

  acts_as_taggable

  validates_presence_of :title,     :if => :article?
  validates_presence_of :permalink, :if => :article?
  validates_presence_of :content

  validates_uniqueness_of :permalink, :if => :article?

  validates_format_of :permalink, :with => /^[a-z,0-9,-]*$/, :if => :article?

  scope :sorted, order("posts.created_at DESC")

  scope :active,    where(:active => true).sorted
  scope :inactive,  where(:active => false).sorted
  scope :blog,      active.limit(10)
  scope :posts,     active.where(:note => false)
  scope :scratches, active.where(:note => true)

  scope :permalink, lambda { |permalink, admin| admin ? where(:permalink => permalink) : active.where(:permalink => permalink) }
  scope :archive,   lambda { |year, month|
    time = Date.new(year.to_i, month.to_i).to_time
    active.where(:created_at => "'#{time}'".."'#{time.end_of_month}'").sorted
  }

  class << self

    def archive_table
      # Thanks to Jean-Babtiste Escoyez for showing this awesome piece of Ruby code!
      active.group_by { |post| post.created_at.year }.inject({}) do |yearly_archive, (year, blog_posts)|
        monthly_archive = blog_posts.group_by { |post| post.created_at.month }.inject({}) do |monthly_archive, (month, blog_posts)|
          monthly_archive.merge({ month => blog_posts.size })
        end
        yearly_archive.update({ year => monthly_archive })
      end
    end

  end

  def article?
    !note
  end

end
