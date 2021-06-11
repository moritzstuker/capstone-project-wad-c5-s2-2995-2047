module ApplicationHelper
  def build_label(obj, format = :name)
    if obj.class == Contact || obj.class == Project || obj.class == Deadline
      format = eval(obj.class::FORMATS[format]) if format.is_a? Symbol
      if format.is_a?(Array)
        separator = format.pop
        sanitize format.reject(&:blank?).join(separator)
      else
        sanitize format
      end
    end
  end
end
