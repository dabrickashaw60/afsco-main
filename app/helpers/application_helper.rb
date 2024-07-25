module ApplicationHelper
  def format_time(time)
    time.strftime("%I:%M %p") if time
  end
end
