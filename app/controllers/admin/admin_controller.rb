class Admin::AdminController < ApplicationController

  before_filter :save_previous_url
  before_filter :authorize

end