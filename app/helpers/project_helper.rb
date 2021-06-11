module ProjectHelper
  def fee (int)
    number_to_currency(int, unit: "fr.", separator: ".", delimiter: "'", format: "%n %u")
  end

  def main_parties (obj, bool = true)
    bool = !bool
    str  = ""

    if bool
      str += "#{build_label(obj.clients.first, :name)}" if obj.clients.exists?
      str += "&nbsp;et al." if obj.clients.count > 1
      str += "&nbsp;v.&nbsp;" if obj.clients.exists? && obj.adversaries.exists?
      str += "#{build_label(obj.adversaries.first, :name)}" if obj.adversaries.exists?
      str += "&nbsp;et al." if obj.adversaries.count > 1
    else
      str += link_to(build_label(obj.clients.first, :name), obj.clients.first) if obj.clients.exists?
      str += "&nbsp;<span class=\"mute\">et al.</span>" if obj.clients.count > 1
      str += "<span class=\"mute\">&nbsp;v.&nbsp;</span>" if obj.clients.exists? && obj.adversaries.exists?
      str += link_to(build_label(obj.adversaries.first, :name), obj.adversaries.first) if obj.adversaries.exists?
      str += "&nbsp;<span class=\"mute\">et al.</span>" if obj.adversaries.count > 1
    end

    sanitize str
  end
end
