module Layouts
  module ApplicationLayoutHelper
    def page_items(str)
      eval("#{str}.search(params[:q])")
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
