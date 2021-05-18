module Layouts
  module ApplicationLayoutHelper
    def page_items(key)
      eval(key.to_s.classify)
    end

    def icon_tag(str)
      doc = File.open("app/assets/images/octicons/#{str}.svg", 'r') { |f| Nokogiri::XML(f) }
      icon = doc.at_css('svg')
      icon['class'] = "icon #{str}"
      raw icon
    end
  end
end
