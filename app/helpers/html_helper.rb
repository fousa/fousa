module HtmlHelper

  def title_tag(title, link=nil)
    render :partial => "helpers/title", :locals => { :title => title, :link => link }
  end

  def admin_links(show=false, type="no", post=nil)
    render :partial => "helpers/admin_links", :locals => { :show => show, :type => type, :post => post }
  end

  def archive_top_tag(link)
    render :partial => "helpers/archive_top", :locals => { :link => link }
  end

  def blog_top_tag(link)
    render :partial => "helpers/blog_top", :locals => { :link => link }
  end

  def paginate_top_tag(posts)
    render :partial => "helpers/paginate_top", :locals => { :posts => posts }
  end

  def paginate_bottom_tag(posts)
    render :partial => "helpers/paginate_bottom", :locals => { :posts => posts }
  end

  def archive_bottom_tag(link)
    render :partial => "helpers/archive_bottom", :locals => { :link => link }
  end

  def blog_bottom_tag(link)
    render :partial => "helpers/blog_bottom", :locals => { :link => link }
  end

  def top_bottom_tag
    render :partial => "helpers/top_bottom"
  end

  def li_tag(selected_title, checked_title, checked_link, keep_linking = false)
    render :partial => "helpers/menu_item", :locals => { :selected_title => selected_title, :checked_title => checked_title, :checked_link => checked_link, :keep_linking => keep_linking }
  end

  def errored_textfield(field, indicator)
    render :partial => "helpers/textfield", :locals => { :field => field, :indicator => indicator }
  end

end