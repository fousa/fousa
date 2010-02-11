module HtmlHelper

  def title_tag(subpage_title, homepage_link=nil)
    html = "<h1>"
    if homepage_link.nil?
      html << "fousa" if homepage_link.nil?
    else
      html << link_to("fousa", root_path)
    end
    html << "<span>#{subpage_title}</span>"
    html << "</h1>"
    html
  end

  def admin_links(show=false, type="no", post=nil)
    return if !show

    html = "<ul class='admin'>"
    if type == "overview"
      html << "<li>"
      html << link_to("new", new_admin_post_path)
      html << "</li><li>"
      html << link_to("list", admin_posts_path)
      html << "</li>"
    elsif type == "new"
      html << "<li>"
      html << link_to("new", new_admin_post_path)
      html << "</li>"
    elsif type == "overview_no_new"
      html << "<li>"
      html << link_to("list", admin_posts_path)
      html << "</li>"
    elsif type == "detail"
      html << "<li>"
      html << link_to("new", new_admin_post_path)
      html << "</li><li>"
      html << link_to("edit", edit_admin_post_path(post))
      html << "</li><li>"
      html << link_to("list", admin_posts_path)
      html << "</li>"
    elsif type == "about"
      html << "<li>"
      html << link_to("edit", edit_admin_post_path(post))
      html << "</li>"
    end
    html << "<li>"
    html << link_to("logoff", logoff_path)
    html << "</li>"
    html << "</ul>"
    html
  end

  def archive_top_tag(link)
    tag  = "<p id='headerlink'>"
    tag << "Check out the "
    tag << link_to("archive &rarr;", link)
    tag << "</p>"
    tag
  end

  def blog_top_tag(link)
    tag  = "<p id='headerlink'>"
    tag << link_to("&larr; back", link)
    tag << " to the blog"
    tag << "</p>"
    tag
  end

  def paginate_top_tag(posts)

    tag = "<p id='headerlink'>"
    tag << will_paginate(posts).to_s
    tag << "</p>"
    tag
  end

  def paginate_bottom_tag(posts)
    tag  ="<p id='more'>"
    tag << "<span class='left_align'>"
    tag << "go to the "
    tag << link_to("top &uarr;", "#menu")
    tag << "</span>"
    tag << will_paginate(posts).to_s
    tag << "</p>"
    tag
  end

  def archive_bottom_tag(link)
    tag = "<p id='more'>"
    tag << "<span class='left_align'>go to the "
    tag << link_to("top &uarr;", "#menu")
    tag << "</span>"
    tag << "Check out the "
    tag << link_to("archive &rarr;", link)
    tag << "</p>"
    tag
  end

  def blog_bottom_tag(link)
    tag  = "<p id='more'>"
    tag << "<span class='left_align'>go to the "
    tag << link_to("top &uarr;", "#menu")
    tag << "</span>"
    tag << link_to( "&larr; back", link)
    tag << " to the blog</p>"
    tag
  end

  def top_bottom_tag
    tag  = "<p id='more'>go to the "
    tag << link_to("&uarr;", "#menu")
    tag << "</p>"
    tag
  end

  def li_tag(selected_title, checked_title, checked_link, keep_linking = false)
    if selected_title == checked_title
      html  = "<li id=\"selected\">"
      if keep_linking
        html << link_to(checked_title, checked_link)
      else
        html << checked_title
      end
      html << "</li>"
    else
      html  = "<li>"
      html << link_to(checked_title, checked_link)
      html << "</li>"
    end
  end

  def show_error(indicator, text)
    "<div id='error'><p>#{text}</p></div>" if indicator
  end

  def show_notice(indicator, text)
    "<div id='success'><p>#{text}</p></div>" if indicator
  end

  def errored_textfield(field, indicator)
    html  = ""
    html << "<div class='error'>" if indicator
		html << field
		html << "</div>" if indicator
	  html
  end

end