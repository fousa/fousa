xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "Fousa Blog"
    xml.description "Jelle Vandebeeck's blog"
    xml.link blog_url

    for post in @posts
      xml.item do
        if post.note
          xml.title "Note by Jelle Vandebeeck"
        else
          xml.title post.title
        end
        xml.description post.content
        xml.pubDate post.created_at.to_s(:rfc822)
        if !post.note
          xml.link permalink_url(post.permalink)
        end
      end
    end
  end
end