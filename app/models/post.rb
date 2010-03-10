class Post < ActiveRecord::Base

  has_many :comments

  acts_as_taggable

  default_value_for :created_at do
    Post.next_time
  end

  validates :title,     :presence => true, :if => Proc.new { |p| not p.note }
  validates :permalink, :presence => true, :if => Proc.new { |p| not p.note }, :uniqueness => true, :format => { :with => /^[a-z,0-9,-]*$/ }
  validates :content,   :presence => true

  scope :sorted, order("posts.created_at DESC")

  scope :active,    lambda { where("created_at <= ?", Time.zone.now).sorted }
  scope :inactive,  lambda { where("created_at > ?",  Time.zone.now).sorted }
  scope :blog,      lambda { active.limit(10) }
  scope :posts,     lambda { active.where(:note => false) }
  scope :scratches, lambda { active.where(:note => true) }

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

    def next_time
      Post.sorted.first.created_at + 3.days
    end

  end

end
