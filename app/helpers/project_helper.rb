module ProjectHelper
  def fee (int)
    "#{number_to_currency(int, unit: "fr.", separator: ".", delimiter: "'", format: "%n %u")}".html_safe
  end

  def main_parties (obj, bool = true)
    bool = !bool
    str  = ""

    if bool
      str += "#{obj.clients.first.combine(:name)}" if obj.clients.exists?
      str += "&nbsp;et al." if obj.clients.count > 1
      str += "&nbsp;V.&nbsp;" if obj.clients.exists? && obj.adversaries.exists?
      str += "#{obj.adversaries.first.combine(:name)}" if obj.adversaries.exists?
      str += "&nbsp;et al." if obj.adversaries.count > 1
      str  = "<span class=\"mute\">#{str}</span>"
    else
      str += link_to(obj.clients.first.combine(:name), obj.clients.first) if obj.clients.exists?
      str += "&nbsp;<span class=\"mute\">et al.</span>" if obj.clients.count > 1
      str += "<span class=\"mute\">&nbsp;v.&nbsp;</span>" if obj.clients.exists? && obj.adversaries.exists?
      str += link_to(obj.adversaries.first.combine(:name), obj.adversaries.first) if obj.adversaries.exists?
      str += "&nbsp;<span class=\"mute\">et al.</span>" if obj.adversaries.count > 1
    end

    str.html_safe
  end
end
