ActionView::Base.field_error_proc = Proc.new do |html_tag, instance|
  "<div class=\"error\">#{html_tag}</div>".html_safe
end