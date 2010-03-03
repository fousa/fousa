class User

  include ActiveModel::Validations

  ### VALIDATIONS ###

  validates :password, :inclusion => { :in => [CONFIG["fousa"]["password"]] }

  ### ACCESSORS ###

  attr_accessor :id,
                :password

  ### INSTANCE METHODS ###

  def initialize(options={})
    [:password].each do |field|
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
