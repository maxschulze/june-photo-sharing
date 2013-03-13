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

end
