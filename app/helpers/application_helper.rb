module ApplicationHelper
  require 'time'

  def time_ago_in_words(date)
    seconds_ago = (Time.now - date).to_i

    case seconds_ago
    when 0...60
      t('datetime.distance_in_words.ago_less_than_a_minute')
    when 60...3600
      minutes_ago = seconds_ago / 60
      minutes_ago == 1 ? t('datetime.distance_in_words.ago_x_minutes.one') : t('datetime.distance_in_words.ago_x_minutes.other', count: minutes_ago)
    when 3600...86_400
      hours_ago = seconds_ago / 3600
      minutes_ago == 1 ? t('datetime.distance_in_words.ago_x_hours.one') : t('datetime.distance_in_words.ago_x_hours.other', count: hours_ago)
    else
      date.strftime('%d-%m-%Y %H:%M:%S')
    end
  end
end
