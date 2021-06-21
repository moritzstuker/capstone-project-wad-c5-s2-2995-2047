module Layouts
  module ApplicationLayoutHelper
    def sidebar_header(str, int)
      sanitize("<span>#{ str }</span><span class=\"counter\">#{ int }</span>") if int.is_a? Integer
    end

    def icon_tag(str, hash = {})
      doc = File.open("app/assets/images/icons/#{str}.svg", 'r') { |f| Nokogiri::XML(f) }
      icon = doc.at_css('svg')
      icon['class']  = "icon #{str}"
      icon['class'] += " #{ hash[:class] }" if hash[:class].present?
      icon.css('path').each do |p|
        p['fill'] = "#{ hash[:fill] }" if hash[:fill].present?
      end
      raw icon
    end

    def avatar_tag_for(user = current_user, str = nil)
      classes = "avatar icon #{ str }"
      img = image_tag(user.avatar, { class: classes, alt: user.name })
      simple_format(img, { class: 'user-avatar' }, wrapper_tag: 'span')
    end

    def dot_label(label, color)
      icon = "<span class='dot-icon' style='background-color: #{ sanitize(color) }'></span>"
      text = "<span>#{ sanitize(label) }</span>"
      "<span class='dot-label'>#{ icon }#{ text }</span>".html_safe
    end
  end
end
