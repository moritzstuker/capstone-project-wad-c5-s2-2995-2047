# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


# Create contacts
puts "   Creating contacts..."
rand(350...500).times do
  personality = Contact::PERSONALITIES.sample
  Contact.create!(
    prefix: personality == "natural" ? ["M.", "Mme"].sample : nil,
    first_name: personality == "natural" ? Faker::Name.first_name : nil,
    last_name: personality == "natural" ? Faker::Name.last_name : Faker::Company.name,
    suffix: personality == "natural" ? Faker::Name.last_name : Faker::Company.suffix,
    phone: Faker::PhoneNumber.cell_phone_in_e164,
    email: Faker::Internet.unique.email,
    address: {
      pobox: [nil, Faker::Address.mail_box].sample,
      street: Faker::Address.street_address,
      streetno: [nil, Faker::Address.building_number].sample,
      zip: Faker::Address.zip_code,
      city: Faker::Address.city,
      country: ["Switzerland", Faker::Address.country].sample
    },
    role: %w(client adversary other).sample,
    personality: personality == "natural" ? "natural" : "legal",
    profession: personality == "natural" ? Faker::Company.profession : Faker::Company.industry,
    notes: [Faker::Hipster.sentence, Faker::Company.buzzword, nil].sample
  )
end
puts "✓  Created #{Contact.all.count} contacts"


# Create one user per role
puts "   Creating users..."
User::ROLES.each do |role|
  username = "#{role}@test.dev"
  User.create!(login: username, password: 'password', role: role)
  puts "   Created user '#{username}'"
end
puts "✓  Created #{User.all.count} users."



contacts_ids = Contact.where(personality: 'natural').sample(User.all.count)

User.all.each_with_index do |user, i|
  user.contact = contacts_ids[i]
  user.save
  contacts_ids[i].role = "employee"
  contacts_ids[i].save
  puts "   Linked user '#{user.login}' with '#{contacts_ids[i].combine(:name)}' (ID: #{contacts_ids[i].id})"
end


project_categories = {
  'Bankruptcy law'        => '#22272e', # dark grey
  'Civil law'             => '#4184e4', # light blue
  'Corporate law'         => '#143d79', # dark blue
  'Criminal law'          => '#922323', # red
  'Data protection'       => '#545d68', # light grey
  'Immigration law'       => '#1b4721', # green
  'Intellectual property' => '#ae7c14', # yellow
  'Labor law'             => '#ae5622'  # orange
}.each do |label, color|
  ProjectCategory.create!(
    label: label,
    color: color
  )
end


rand(501...750).times do
  Project.create!(
    label: Faker::Hipster.unique.sentence(word_count: 3),
    description: [Faker::Hipster.paragraph, nil].sample,
    fee: [180, 250, 300, 330, 350, 400].sample,
    status: ["active", "inactive"].sample,
    category: ProjectCategory.all.sample,
    parties: Contact.where(role: 'client').sample(rand(1..3)) + Contact.where(role: 'adversary').sample(rand(0..3))
  )
end
puts "✓  Created #{Project.all.count} cases."

puts "✓  Done, good to go!"
