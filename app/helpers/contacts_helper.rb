module ContactsHelper
  def build_address(person)
    simple_format([
      person.pobox,
      person.street,
      person.city,
      person.country
    ].reject(&:blank?).join("\n"))
  end

  def tel_search_content (person)
    str  = ""
    str += "#{ person['occupation'].capitalize }\n" if person['occupation']
    str += "#{ person['street'] } #{ person['streetno'] }\n"
    str += "#{ person['zip'] } #{ person['city'] } (#{ person['canton'] })"
    str
  end

  def tel_search_link (person)
    person['link'].detect {|i| i["rel"] == "alternate" }['href']
  end

  def tel_search_data(person)
    category = (person['type'].present? && person['type'].strip == 'Organisation') ? :company : :person
    name = "#{ person['firstname'].strip if person['firstname'].present? } #{ person['name'].strip if person['name'].present? }".strip
    country = (person['country'].present? && person['country'].strip == 'ch') ? 'Switzerland' : nil
    uid = "tel_search:#{person['id'].last}"

    return {
      category:   category,
      name:       name,
      activity:   person['occupation'].present? ? person['occupation'].strip.capitalize : nil,
      street:     person['street'].present? ? person['street'].strip : nil,
      streetno:   person['streetno'].present? ? person['streetno'].strip : nil,
      zip:        person['zip'].present? ? person['zip'].strip : nil,
      city:       person['city'].present? ? person['city'].strip : nil,
      country:    country,
      phone:      person['phone'].present? ? person['phone'].strip : nil,
      import_uid: uid
    }
  end
end
