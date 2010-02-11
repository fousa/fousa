module DateHelper

  def last_updated(date)
    time_ago_in_words(date)
  end

  def last_updated_sql(date)
    date.strftime("%Y%m%d")
  end

  def format_time_ago(date)
     " // #{time_ago_in_words(date)} ago"
  end

  def format_month(date)
    date.strftime("%b").upcase
  end

end