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
      avatar = image_tag(user.avatar, { class: "avatar icon #{ str }", alt: user.name })
      simple_format("#{avatar}#{user.name}", { class: 'icon-text' }, wrapper_tag: 'span')
    end

    def dot_label(label, color)
      icon = "<span class='dot icon' style='background-color: #{ sanitize(color) }'></span>"
      simple_format("#{ icon }#{ sanitize(label) }", { class: 'icon-text dot-label' }, wrapper_tag: 'span', sanitize: false)
    end
  end
end
