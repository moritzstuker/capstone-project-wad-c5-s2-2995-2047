module Layouts
  module ApplicationLayoutHelper
    def page_items(class_name)
      eval("#{class_name}.search(params[:q])").count
    end

    def icon_tag(str, hash = {})
      doc = File.open("app/assets/images/octicons/#{str}.svg", 'r') { |f| Nokogiri::XML(f) }
      icon = doc.at_css('svg')
      icon['class']  = "icon #{str}"
      icon['class'] += " #{hash[:class]}" if hash.present?
      raw icon
    end
  end
end
