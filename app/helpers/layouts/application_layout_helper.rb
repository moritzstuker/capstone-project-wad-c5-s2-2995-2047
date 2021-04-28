module Layouts
  module ApplicationLayoutHelper
    def page_items(key)
      eval(key.to_s.classify).all
    end
  end
end
