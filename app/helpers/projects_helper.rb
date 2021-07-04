module ProjectsHelper
  def fee (int)
    number_to_currency(int, unit: "fr.", format: "%n %u")
  end

  def main_parties (project)
    clients = link_to(project.clients.first.name, project.clients.first) if project.clients.exists?
    clients_suffix = "<span class=\"mute\">et al.</span>" if project.clients.count > 1
    versus = "<span class=\"mute\">v.</span>" if project.clients.exists? && project.adversaries.exists?
    adversaries = link_to(project.adversaries.first.name, project.adversaries.first) if project.adversaries.exists?
    adversaries_suffix = "<span class=\"mute\">et al.</span>" if project.adversaries.count > 1
    sanitize([clients, clients_suffix, versus, adversaries, adversaries_suffix].reject(&:blank?).join(' '))
  end

  def build_deadline_text(str)
    "PLUT #{str.inspect}"
  end
end
