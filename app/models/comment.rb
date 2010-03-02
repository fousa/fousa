class Comment < ActiveRecord::Base

  ### ASSOCIATIONS ###

  belongs_to :post

  ### VALIDATIONS ###

  validates :name,    :presence  => true
  validates :comment, :presence  => true
  validates :website, :format    => { :with => /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$/ix }, :if => Proc.new { |c| not c.website.blank? }
  validates :email,   :format    => { :with => /^.+@[^\.].*\.[a-z]{2,}$/ix },                                                           :if => Proc.new { |c| not c.email.blank? }
  validates :snow,    :inclusion => { :in   => %w( cold ) }

  ### ACCESSORS ###

  attr_accessor :snow

  ### SCOPES ###

  scope :sorted, order("comments.created_at ASC")

  ### CALLBACKS ###

  before_validation :set_personal_comment_data

  private

    def set_personal_comment_data
      if personal_comment
        self.name    = "Jelle Vandebeeck"
        self.email   = "jelle@fousa.be"
        self.website = "http://www.fousa.be"
        self.snow    = "cold"
      end
    end

end
