# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


# Create one user per role
puts "   Creating users..."
User::ROLES.each do |role|
  username = "#{role}@test.dev"
  User.create!(login: username, password: 'password', role: role)
  puts "   Created user '#{username}'"
end
puts "✓  Created #{User.all.count} users."


# Create 100 contacts
puts "   Creating contacts..."
rand(250...350).times do
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
    notes: [Faker::Company.buzzword, nil].sample
  )
end
puts "✓  Created #{Contact.all.count} contacts"
puts "✓  Done, good to go!"
