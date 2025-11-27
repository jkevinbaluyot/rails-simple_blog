module ApplicationHelper
  include Pagy::Frontend

  def time_format(time)
    return if time.nil?


    time.to_formatted_s(:long)
  end

  def canonical_tag(url)
    content_for :canonical do
      tag.link(rel: "canonical", href: url)
    end
  end
end
