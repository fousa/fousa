class Contact

  include ActiveModel::Validations

  validates :name,    :presence  => true
  validates :content, :presence  => true
  validates :website, :format    => { :with => /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$/ix }, :if => Proc.new { |c| not c.website.blank? }
  validates :email,   :format    => { :with => /^.+@[^\.].*\.[a-z]{2,}$/ix }
  validates :snow,    :inclusion => { :in   => %w( cold ) }

  attr_accessor :id,
                :name,
                :email,
                :website,
                :snow,
                :content

  def initialize(options={})
    [:name, :email, :website, :snow, :content].each do |field|
      class << self
        self
      end.module_eval{attr_accessor field}
      self.send("#{field}=", options[field.to_sym])
    end
  end

  def new_record?
    true
  end

end
