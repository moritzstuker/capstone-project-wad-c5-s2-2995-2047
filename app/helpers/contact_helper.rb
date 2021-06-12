module ContactHelper
  def tel_search_address (person)
    str  = ""
    str += "#{ person['occupation'] }\n" if person['occupation']
    str += "#{ person['street'] } #{ person['streetno'] }\n"
    str += "#{ person['zip'] } #{ person['city'] } (#{ person['canton'] })"
    str
  end

  def tel_search_link (person)
    person['link'].detect {|i| i["rel"] == "alternate" }['href']
  end
end
