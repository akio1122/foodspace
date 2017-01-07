module Pixelbash::Helpers::Snippets

   def format_date(time, format='%d.%m.%Y', blank_message="&nbsp;")
    time.blank? ? blank_message : time.strftime(format)
  end

  def format_when(date)
    from_time = Time.now
    distance_of_time_in_words(from_time, date) 
  end

  def format_excerpt(excerpt, length=50, strip_html=true)
    excerpt = AutoExcerpt.new(excerpt, :characters => length, :strip_html => strip_html, :allowed_tags => %w(p em strong), :ending => '...')
    excerpt.html_safe
  end

  def format_content(content)
    content.html_safe
  end

end