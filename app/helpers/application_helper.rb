module ApplicationHelper
  def render_svg(name, option)
    svg_name = "#{name}.svg"
    inline_svg_tag(svg_name, option)
  end
end
