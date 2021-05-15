# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

{
  'client'    => '#2b6a30', # $green-600
  'adversary' => '#ad2e2c', # $red-600
  'employee'  => '#255ab2', # $blue-600
  'other'     => '#94471b'  # $orange-600
}.each do |label, color|
  ContactRole.create!(
    label: label,
    color: color
  )
end
puts "✓  Generated contact roles."


puts "   Generating seed data... this will take some time."

# Create contacts
rand(35..50).times do
  category = Contact::PERSONALITIES.sample
  Contact.create!(
    prefix:     category == "natural person" ? ["M.", "Mme"].sample : nil,
    first_name: category == "natural person" ? Faker::Name.first_name : nil,
    last_name:  category == "natural person" ? Faker::Name.last_name : Faker::Company.name,
    suffix:     category == "natural person" ? nil : Faker::Company.suffix,
    phone:      Faker::PhoneNumber.cell_phone_in_e164,
    email:      Faker::Internet.unique.email,
    birthday:   Faker::Date.birthday(min_age: 18, max_age: 100),
    address: {
      pobox:      [nil, Faker::Address.mail_box].sample,
      street:     Faker::Address.street_address,
      streetno:   [nil, Faker::Address.building_number].sample,
      zip:        Faker::Address.zip_code,
      city:       Faker::Address.city,
      country:    ["Switzerland", Faker::Address.country].sample
    },
    role:       ContactRole.all.except(:employee).sample,
    category:   category,
    profession: category == "natural person" ? Faker::Company.profession : Faker::Company.industry,
    notes:      [Faker::Hipster.sentence, Faker::Company.buzzword, nil].sample
  )
end
puts "✓  Created #{Contact.all.count} contacts"


# Create one user per access_level
puts "   Creating users..."
target_contacts = Contact.where(category: 'natural person').sample(User::ROLES.count)

User::ROLES.each_with_index do |access_level, i|
  username = "#{access_level}@test.dev"

  User.create!(
    login:        username,
    password:     'password',
    access_level: access_level,
    contact:      target_contacts[i]
  )
  target_contacts[i].role = ContactRole.find_by_label('employee')
  target_contacts[i].save!
  puts "   Created user '#{username}' and added link with '#{target_contacts[i].combine(:name)}' (ID: #{target_contacts[i].id})"
end
puts "✓  Created #{User.all.count} users."


{
  'bankruptcy law'        => '#22272e', # dark grey
  'civil law'             => '#4184e4', # light blue
  'corporate law'         => '#143d79', # dark blue
  'criminal law'          => '#922323', # red
  'data protection'       => '#545d68', # light grey
  'immigration law'       => '#1b4721', # green
  'intellectual property' => '#ae7c14', # yellow
  'labor law'             => '#ae5622'  # orange
}.each do |label, color|
  ProjectCategory.create!(
    label: label,
    color: color
  )
end
puts "✓  Generated project categories."


rand(20..30).times do
  ref_no = ('A'..'Z').to_a.sample(2).join + (12..21).to_a.sample.to_s + "." + (000000..999999).to_a.sample.to_s + "-" + ('A'..'Z').to_a.sample(3).join
  Project.create!(
    label:       Faker::Hipster.words(number: 2).join(' ').capitalize,
    description: [Faker::Hipster.paragraph, nil].sample,
    fee:         [180, 250, 300, 330, 350, 400].sample,
    status:      Project::STATUS.sample,
    category:    ProjectCategory.all.sample,
    parties:     Contact.all.sample(5),
    #parties:     Contact.where(role: 'client').sample(rand(1..3)) + Contact.where(role: 'adversary').sample(rand(0..3)),
    reference:   [ref_no.to_s, nil].sample
  )
end
puts "✓  Created #{Project.all.count} cases."


rand(150..200).times do
  Activity.create!(
    label:    Faker::Company.bs.capitalize,
    category: Activity::CATEGORIES.sample,
    duration: rand(0.1..8.0).round(1),
    date:     Faker::Date.backward(days: 1000),
    project:  Project.all.sample,
    user:     User.all.sample
  )
end
puts "✓  Created #{Activity.all.count} activities."


rand(50..75).times do
  Deadline.create!(
    label:    Faker::Company.bs.capitalize,
    category: Deadline::CATEGORIES.sample,
    date:     Faker::Date.forward(days: 300),
    project:  Project.all.sample
    ## ADD PROJECT USER
  )
end
puts "✓  Created #{Deadline.all.count} deadlines."

puts "✓  Done, good to go!"
