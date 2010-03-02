class ArchiveController < ApplicationController

  before_filter :save_previous_url

  def index
    @selected_year  = params[:year]  ? params[:year]  : Time.now.strftime("%Y")
    @selected_month = params[:month] ? params[:month] : Time.now.strftime("%m")

    @posts   = Post.archive(@selected_year, @selected_month)
    @archive = Post.archive_table

    initialize_archive
  end

  private

    def initialize_archive
      @title         = "archive"
      @selected      = "blog"
      @keep_linking  = true
    	@admin_section = "overview"
    	@keywords      = (%w( fousa blog jelle\ vandebeeck heverlee) + @posts.map(&:tag_list).flatten).join(",")
    end

end