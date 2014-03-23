module ApplicationHelper

  def breadcrumbs(&block)
    content_tag(:div, class: 'row') do
      content_tag(:div, class: 'col-md-12') do
        content_tag(:ol, class: 'breadcrumb') do
          block.call
        end
      end
    end
  end

  def breadcrumb(title, path, options = {})
    active = options[:active].presence || (path == request.path)

    if active
      content_tag(:li, title, class: 'active')
    else
      content_tag(:li) do
        link_to(title, path)
      end
    end
  end

  def nav_link(name, target)
    content_tag(:li, class: "#{'active' if current_page?(target)}") do
      link_to t(name), target
    end
  end

  def flash_css_class(type)
    case type.to_sym
    when :success, :notice
      'success'
    when :error, :alert
      'warning'
    else
      'info'
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
