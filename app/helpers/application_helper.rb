module ApplicationHelper
  
  def nav_link(name, options = {})
    klasses = ''
    klasses << " active" if request.path == options[:url] or controller_name == options[:controller]
    content_tag(:li, class: klasses) do
      link_to name, options[:url]
    end
  end
  
end
