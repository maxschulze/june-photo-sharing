module ApplicationHelper

  def nav_link(name, options = {})
    url = options.delete(:url)
    controller = options.delete(:controller)

    klasses = ''
    klasses << " active" if request.path == url or (controller.present? and controller_name == controller)
    content_tag(:li, class: klasses) do
      link_to name, url, options
    end
  end
  
  def localize_if_date(string)
    if string.is_a?(Date) or string.is_a?(ActiveSupport::TimeWithZone)
      l(string.to_date)
    else
      string
    end
  end

end
