module ApplicationHelper
  def format_time(time)
    time.strftime("%I:%M %p") if time
  end
  def sort_direction(column)
    if column == params[:sort]
      params[:direction] == "asc" ? "desc" : "asc"
    else
      "asc"
    end
  end
end
