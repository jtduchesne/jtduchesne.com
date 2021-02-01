module ApplicationHelper
  def relative_date(time)
    date = time.to_date
    if date >= Date.yesterday
      time_ago = l(time, format: :short)
    else
      time_ago = time_ago_in_words(time)
    end
    t('relative_date', scope: 'datetime.distance_in_words', count: (Date.today - date), time_ago: time_ago)
  end
end
