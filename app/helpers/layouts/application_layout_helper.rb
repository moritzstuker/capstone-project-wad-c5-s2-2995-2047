module Layouts
  module ApplicationLayoutHelper
    def sidebar_header(str, int)
      sanitize("<span>#{ str }</span><span class=\"counter\">#{ int }</span>") if int.is_a? Integer
    end

    def icon_tag(str, hash = {})
      doc = File.open("app/assets/images/icons/#{str}.svg", 'r') { |f| Nokogiri::XML(f) }
      icon = doc.at_css('svg')
      icon['class']  = "icon #{str}"
      icon['class'] += " #{hash[:class]}" if hash.present?
      raw icon
    end
  end
end
