module SearchHelper

  def highlight_results(text, query, max=150)
    text = strip_tags(text)
    text = excerpt(text, query, radius = max)
    highlight(text, query)
  end

  def highlight(text, phrases, *args)
    options = args.extract_options!
    unless args.empty?
      options[:highlighter] = args[0] || '<span class="yellow">\1</span>'
    end
    options.reverse_merge!(:highlighter => '<span class="yellow">\1</span>')

    if text.blank? || phrases.blank?
      raw text
    else
      match = Array(phrases).map { |p| Regexp.escape(p) }.join('|')
      raw text.gsub(/(#{match})/i, options[:highlighter])
    end
  end

end