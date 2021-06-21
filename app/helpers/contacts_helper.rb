module ContactsHelper
  def build_address(person)
    simple_format([
      person.pobox,
      person.street,
      person.city,
      person.country
    ].reject(&:blank?).join("\n"))
  end
end
