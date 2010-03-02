module PostsHelper

  def format_comment_text(post)
    size = post.comments.count
    if size > 0
      " // #{size} #{size == 1 ? "comment" : "comment".pluralize}"
    end
  end

  def format_overview_content(content, max=350)
    truncate strip_tags(content), { :length => max, :omission => "..." }
  end

end