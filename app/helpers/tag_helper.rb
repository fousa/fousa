module TagHelper

  def format_tag_list(post)
    html  = ""
    if post.tag_list.size > 0
  		html << "<ul id=\"tags\">"
  		post.tag_list.each do |tag|
  			html <<	"<li>"
  			html << link_to(tag.downcase, tag_path(tag.downcase))
  			html <<	"</li>"
  		end
  		html << "</ul>"
  	end
  	raw html
  end

end