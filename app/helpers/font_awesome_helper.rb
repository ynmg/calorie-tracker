module FontAwesomeHelper
  def fa_icon(icon, style: :solid, size: nil, animation: nil, color: nil, animation_duration: nil)
    classes = []
    classes << case style
                  when :solid then "fas"
                  when :regular then "far"
                  when :light then "fal"
                  when :duotone then "fad"
                  else "fa"
                  end
    classes << "fa-#{icon}"
    classes << "fa-#{size}" if size
    classes << "fa-#{animation}" if animation

    style_attr = ""
    style_attr += "color: #{color};" if color
    style_attr += "animation-duration: #{animation_duration};" if animation_duration

    content_tag(:i, "", class: classes.join(" "), style: style_attr.presence)
    # content_tag(:i, "", class: "#{style_class} fa-#{icon}")
  end
end
