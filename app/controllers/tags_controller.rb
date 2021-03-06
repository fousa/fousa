class TagsController < ApplicationController

  before_filter :set_previous_url

  def index
    @tags = Post.tag_counts_on :tags, :conditions => ["posts.created_at <= ?", Time.zone.now]

    initialize_cloud
  end

  def show
    @tag   = Tag.where(:name => params[:id])
    @posts = Post.tagged_with(@tag).sorted

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
      @title         = "#{@tag.name} tag"
      @selected      = "cloud"
      @keep_linking  = true
    	@admin_section = "overview"
    	@keywords      = (%w( fousa blog jelle\ vandebeeck heverlee ) + [@tag.name]).join(",")
    end

end