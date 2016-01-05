module ApplicationHelper
  def dropdown_toggle_link(name)
    link_to "#{name} <span class='carat'></span>".html_safe, '#', class: 'dropdown-toggle',
            data: { toggle: 'dropdown' }, role: 'button', aria: { haspopup: 'true', expanded: 'false' }
  end
end
