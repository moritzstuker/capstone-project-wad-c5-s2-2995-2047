# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

rand_min = 50
rand_max = (rand_min * 1.5).round

LEGALESE = [
  "Action de droit administratif",
  "Action en constatation",
  "Affection psychique",
  "Affermage par parcelles",
  "Arbitrage international",
  "Assistant social",
  "Assurance pour perte de patrimoine",
  "Autorité universitaire",
  "Banque confirmatrice",
  "Bulletin de vote",
  "Casier judiciaire",
  "Catalogue des animaux",
  "Catalogue des données chronologiques",
  "Connaissement",
  "Constitutionnalité",
  "Contrat d'épargne-logement",
  "Contrat de rente viagère",
  "Convention de l'oit",
  "Convention sur les armes à sous-munitions",
  "Courtier en annonces",
  "Coxarthrose",
  "Décompte final",
  "Déduction des versements d'utilité publique",
  "Défiguration",
  "Détention injustifiée",
  "Divorce",
  "Dispositions pénales de la ltbc",
  "Droit à l'antenne",
  "Droit d'auteur et droits voisins",
  "Droit d'être arrêté",
  "Erreur de déclaration",
  "Établissement de crédit",
  "État fédéral",
  "Fonction de la forêt",
  "Force distinctive",
  "Gage immobilier",
  "Guerre maritime",
  "Impôt cantonal et communal",
  "Indemnité en cas d'insolvabilité",
  "Insaisissabilité",
  "Interprétation uniforme",
  "Jura novit curia",
  "Lacune d'assurance",
  "Médecin conventionné",
  "Mesure diagnostique",
  "Mise en liberté provisoire",
  "Nouvelle construction",
  "Organe d'appel de l'omc",
  "Orientation de la production",
  "Politique foncière",
  "Procès de nuremberg",
  "Procès équitable",
  "Propres actions",
  "Propriété exclusive",
  "Réduction du traitement",
  "Renonciation au brevet",
  "République démocratique allemande",
  "Réquisition de continuer la poursuite",
  "Saisie provisoire",
  "Salaire en nature",
  "Science de l'information",
  "Sécurité militaire",
  "Société en commandite par actions",
  "Sous-licence",
  "Supplément de salaire",
  "Tableau d'affichage",
  "Tâche de droit public",
  "Trafic illicite de stupéfiants",
  "Transplantation du foie",
  "Travaux accessoires",
  "Usage commun"
].shuffle

AVATARS = Dir.glob("#{Rails.root}/app/assets/images/fallback_avatars/*.jpg").shuffle

def build_activity
  project = Project.all.sample
  activity_user = (project.assignees.to_a ||= []) << project.owner
  activity_user = activity_user.sample
  Activity.create!(
    label:    Faker::Company.bs.capitalize,
    category: Activity::CATEGORIES.sample,
    duration: rand(0.1..8.0).round(1),
    date:     Faker::Date.backward(days: 1000),
    project:  project,
    user:     activity_user,
    fee:      activity_user.fee
  )
end

def build_case
  # Ref number format is canonical in Canton de Vaud
  ref_no = ('A'..'Z').to_a.sample(2).join + (12..21).to_a.sample.to_s + "." + (000000..999999).to_a.sample.to_s + "-" + ('A'..'Z').to_a.sample(3).join
  case_owner = User.partners.sample()
  case_assignees = User.lawyers.sample(rand(1...3)).to_a.reject { |user| user == case_owner}
  Project.create!(
    label:       LEGALESE.shuffle.pop,
    description: [Faker::Hipster.paragraph, nil][weighted_random(0.5)],
    status:      Project::STATUS.sample,
    category:    ProjectCategory.all.sample,
    clients:     Contact.clients.sample(rand(1...3)),
    adversaries: Contact.adversaries.sample(rand(0...5)),
    reference:   [ref_no.to_s, nil].sample,
    owner:       case_owner,
    assignees:   case_assignees
  )
end

def build_contact(str = "client")
  company = (str == "employee") ? false : [true, false][weighted_random()];
  address = ContactAddress.create!(
    pobox:      [nil, Faker::Address.mail_box][weighted_random()],
    street:     Faker::Address.street_name,
    streetno:   [nil, Faker::Address.building_number][weighted_random()],
    zip:        Faker::Address.zip_code,
    city:       Faker::Address.city,
    country:    ["Switzerland", Faker::Address.country][weighted_random()]
  )
  Contact.create!(
    prefix:     company ? nil : ["M.", "Mme"].sample,
    first_name: company ? nil : Faker::Name.first_name,
    last_name:  company ? Faker::Company.name : Faker::Name.last_name,
    suffix:     company ? Faker::Company.suffix : nil,
    address:    address,
    phone:      Faker::PhoneNumber.cell_phone_in_e164,
    email:      Faker::Internet.unique.email,
    birthday:   company ? nil : Faker::Date.birthday(min_age: 18, max_age: 100),
    activity:   company ? Faker::Company.industry : (str == "employee" ? 'Lawyer' : Faker::Company.profession),
    company_id: company ? Faker::IDNumber.valid : nil,
    company:    company,
    notes:      [nil, Faker::Hipster.sentence][weighted_random()],
    role:       ContactRole.find_by_label(str)
  )
end

def build_contact_role(arr)
  ContactRole.create!(
    label: arr[0],
    color: arr[1]
  )
end

def build_deadline
  project = Project.all.sample
  assignee = (project.assignees.to_a ||= []) << project.owner
  Deadline.create!(
    label:        Faker::Company.bs.capitalize,
    category:     Deadline::CATEGORIES.sample,
    date:         Faker::Date.forward(days: 350),
    project:      project,
    assignee:     assignee.sample,
    completed_at: [Faker::Time.backward(days: 14), nil][weighted_random(0.8)]
  )
end

def build_project_category(arr)
  ProjectCategory.create!(
    label: arr[0],
    color: arr[1]
  )
end

def build_user(obj, filler = false)
  user = User.create!(
    login:    filler ? Faker::Internet.username : "#{obj.label}@test.dev",
    password: "password",
    role:     obj,
    avatar:   "fallback_avatars/#{AVATARS[rand(1...10)].split('/').last}",
    contact:  build_contact("employee")
  )
  puts "   Generated user '#{user.login}' (#{user.role.label})."
end

def build_user_role(hash)
  UserRole.create!(
    label:        hash[0].to_s,
    access_level: hash[1][:access_level].to_i,
    default_fee:  hash[1][:default_fee].to_f
  )
end

def weighted_random(float = 0.8)
  float <= rand(0.0..1.0) ? 0 : 1
end

puts "   Generating contact roles..."
ContactRole::DEFAULTS.each do |e|
  build_contact_role(e)
end
puts "✓  Successfully generated #{ContactRole.all.count} contact roles."

puts "   Generating one user per role..."
UserRole::DEFAULTS.each do |e|
  role = build_user_role(e)
  build_user(role)
end
puts "✓  Successfully generated #{User.all.count} users."

puts "   Generating additional users..."
rand((rand_min / 10)...(rand_max / 10)).times do |i|
  role = UserRole.all[1..-1].sample
  build_user(role, true)
end
puts "✓  Successfully generated a total of #{User.all.count} users."

puts "   Generating project categories..."
ProjectCategory::DEFAULTS.each do |e|
  build_project_category(e)
end
puts "✓  Successfully generated #{ProjectCategory.all.count} project categories."

puts "   Generating contacts..."
rand(rand_min...rand_max).times do |i|
  role = ContactRole::DEFAULTS.except(:employee).map { |k,v| [k] }.sample
  build_contact(role)
  puts "   already generated #{i} contacts, still more to go..." if i % 100 == 0 && i > 0
end
puts "✓  Successfully generated #{Contact.all.count} contacts."

puts "   Generating cases..."
rand(rand_min...rand_max).times do |i|
  build_case()
  puts "   already generated #{i} cases, still more to go..." if i % 100 == 0 && i > 0
end
puts "✓  Successfully generated #{Project.all.count} cases."

puts "   Generating activities..."
rand((rand_min * 10)...(rand_max * 10)).times do |i|
  build_activity()
  puts "   already generated #{i} activities, still more to go..." if i % 100 == 0 && i > 0
end
puts "✓  Successfully generated #{Activity.all.count} activities."

puts "   Generating deadlines..."
rand((rand_min * 2)...(rand_max * 2)).times do |i|
  build_deadline()
end
puts "✓  Successfully generated #{Deadline.all.count} deadlines."
