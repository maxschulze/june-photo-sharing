module ApplicationHelper

  def breadcrumbs(&block)
    content_tag(:div, class: 'row-fluid breadcrumbs') do
      content_tag(:div, class: 'span12') do
        content_tag(:ul, class: 'breadcrumb') do
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
        [ link_to(title, path), content_tag(:span, '/', class: 'divider') ].join(" ").html_safe
      end
    end
  end

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
