class Comment < ActiveRecord::Base

  belongs_to :post

  attr_accessor :snow

  validates_presence_of :name
  validates_presence_of :comment

  validates_format_of :website, :allow_nil => true, :if => Proc.new { |c| not c.website.blank? }, :with => /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$/ix, :message => "must be a valid url"
  validates_format_of :email,   :allow_nil => true, :if => Proc.new { |c| not c.email.blank? },   :with => /^.+@[^\.].*\.[a-z]{2,}$/ix,                                                           :message => "must be a valid email"

  validates_inclusion_of :snow, :in => %w( cold )

  scope :sorted, order("comments.created_at ASC")

end
