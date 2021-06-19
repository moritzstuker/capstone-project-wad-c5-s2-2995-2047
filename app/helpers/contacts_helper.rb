module ContactsHelper
  def build_name(person = current_user)
    sanitize([
      person.first_name,
      person.last_name
    ].reject(&:blank?).join(' '))
  end

  def build_address(person)
    simple_format([
      person.pobox,
      "#{ person.street }#{ '&nbsp;' + person.streetno if person.streetno }",
      "#{ person.zip + '&nbsp;' if person.zip }#{ person.city }",
      person.country
    ].reject(&:blank?).join("\n"))
  end
end
