class ArchiveController < ApplicationController

  before_filter :save_previous_url

  def index
    @selected_year  = params[:year]  ? params[:year]  : Time.now.strftime("%Y")
    @selected_month = params[:month] ? params[:month] : Time.now.strftime("%m")

    @posts   = Post.archive(@selected_year, @selected_month)
    @archive = Post.count_archive

    initialize_archive
  end

  private

    def initialize_archive
      @title         = "blog"
      @selected      = "blog"
      @keep_linking  = false
    	@admin_section = "overview"
    	@keywords      = (%w( fousa blog jelle\ vandebeeck heverlee) + @posts.map(&:keywords).flatten).join(",")
    end

end