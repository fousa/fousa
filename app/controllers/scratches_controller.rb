class ScratchesController < ApplicationController

  before_filter :save_previous_url

  def index
    initialize_scratches

    @scratches = Post.scratches.paginate(:page => params[:page], :per_page => 10)
  end

  private

    def initialize_scratches
      @title         = "scratches"
      @selected      = "scratches"
      @keep_linking  = false
    	@admin_section = "overview"
    end

end