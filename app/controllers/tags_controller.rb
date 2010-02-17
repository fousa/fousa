class TagsController < ApplicationController

  before_filter :save_previous_url

  def index
    @tags = Post.tag_counts_on :tags, :conditions => { :active => true }

    initialize_cloud
  end

  def show
    @tag   = Tag.find_by_name(params[:id])
    @posts = Post.tagged_with(@tag).order("created_at desc")

    initialize_tag
  end

  private

    def initialize_cloud
      @title         = "cloud"
      @selected      = "cloud"
      @keep_linking  = false
    	@admin_section = "overview"
    	@keywords      = (%w( fousa blog jelle\ vandebeeck heverlee) + @tags.map(&:name)).join(",")
    end

    def initialize_tag
      @title         = "blog"
      @selected      = "blog"
      @keep_linking  = true
    	@admin_section = "overview"
    	@keywords      = (%w( fousa blog jelle\ vandebeeck heverlee ) + [@tag.name]).join(",")
    end

end