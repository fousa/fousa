class Admin::AdminController < ApplicationController

  before_filter :set_previous_url
  before_filter :authorize

end