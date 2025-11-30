module ApplicationHelper
  include Pagy::Frontend

  def time_format(time, format = :long)
    return if time.nil?

    time.to_formatted_s(format)
  end

  def canonical_tag(url)
    content_for :canonical do
      tag.link(rel: "canonical", href: url)
    end
  end


  def time_custom_format(time)
    return if time.nil?

    time.strftime("%B %d ")
  end
end
