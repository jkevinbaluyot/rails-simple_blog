module ApplicationHelper
  def time_format(time)
    return if time.nil?


    time.to_formatted_s(:long)
  end
end
