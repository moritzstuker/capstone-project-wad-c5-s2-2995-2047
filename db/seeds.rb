# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts "   Generating seed data... this will take some time."

# Create contacts
rand(35..50).times do
  category = Contact::PERSONALITIES.sample
  Contact.create!(
    prefix:     category == "natural person" ? ["M.", "Mme"].sample : nil,
    first_name: category == "natural person" ? Faker::Name.first_name : nil,
    last_name:  category == "natural person" ? Faker::Name.last_name : Faker::Company.name,
    suffix:     category == "natural person" ? Faker::Name.last_name : Faker::Company.suffix,
    phone:      Faker::PhoneNumber.cell_phone_in_e164,
    email:      Faker::Internet.unique.email,
    address: {
      pobox:      [nil, Faker::Address.mail_box].sample,
      street:     Faker::Address.street_address,
      streetno:   [nil, Faker::Address.building_number].sample,
      zip:        Faker::Address.zip_code,
      city:       Faker::Address.city,
      country:    ["Switzerland", Faker::Address.country].sample
    },
    role:       %w(client adversary other).sample,
    category:   category,
    profession: category == "natural person" ? Faker::Company.profession : Faker::Company.industry,
    notes:      [Faker::Hipster.sentence, Faker::Company.buzzword, nil].sample
  )
end
puts "✓  Created #{Contact.all.count} contacts"


# Create one user per role
puts "   Creating users..."
User::ROLES.each do |role|
  username = "#{role}@test.dev"
  User.create!(
    login:    username,
    password: 'password',
    role:     role
  )
  puts "   Created user '#{username}'"
end
puts "✓  Created #{User.all.count} users."



contacts_ids = Contact.where(category: 'natural person').sample(User.all.count)

User.all.each_with_index do |user, i|
  user.contact = contacts_ids[i]
  user.save!
  contacts_ids[i].role = "employee"
  contacts_ids[i].save!
  puts "   Linked user '#{user.login}' with '#{contacts_ids[i].combine(:name)}' (ID: #{contacts_ids[i].id})"
end
puts "✓  Linked users with contacts."


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
puts "✓  Generated project categories."


rand(50..75).times do
  ref_no = ('A'..'Z').to_a.sample(2).join + (12..21).to_a.sample.to_s + "." + (000000..999999).to_a.sample.to_s + "-" + ('A'..'Z').to_a.sample(3).join
  Project.create!(
    label:       Faker::Hipster.words(number: 2).join(' ').capitalize,
    description: [Faker::Hipster.paragraph, nil].sample,
    fee:         [180, 250, 300, 330, 350, 400].sample,
    status:      Project::STATUS.sample,
    category:    ProjectCategory.all.sample,
    parties:     Contact.where(role: 'client').sample(rand(1..3)) + Contact.where(role: 'adversary').sample(rand(0..3)),
    reference:   [ref_no.to_s, nil].sample
  )
end
puts "✓  Created #{Project.all.count} cases."


rand(1500..2000).times do
  Activity.create!(
    label:    Faker::Company.bs.capitalize,
    category: Activity::CATEGORIES.sample,
    duration: rand(0.1..8.0).round(1),
    date:     rand(Date.today.prev_year...Date.today),
    project:  Project.all.sample,
    user:     User.all.sample
  )
end
puts "✓  Created #{Activity.all.count} activities."


rand(50..75).times do
  Deadline.create!(
    label:    Faker::Company.bs.capitalize,
    category: Deadline::CATEGORIES.sample,
    date:     rand(Date.today..Date.today.next_year),
    project:  Project.all.sample
    ## ADD PROJECT USER
  )
end
puts "✓  Created #{Deadline.all.count} deadlines."

puts "✓  Done, good to go!"
