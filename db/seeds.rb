# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

rand_min = 200
rand_max = (rand_min * 1.5).round

AVATARS = Dir.glob("#{Rails.root}/app/assets/images/fallback_avatars/*.jpg").shuffle

def build_activity
  project = Project.all.sample
  activity_user = User.lawyers.sample
  Activity.create!(
    label:     Faker::Company.bs.capitalize,
    category:  Activity::CATEGORIES.sample,
    date: Faker::Date.backward(days: 1000),
    duration:  rand(0.1..8.0).round(1),
    fee:       activity_user.default_fee,
    project:   project,
    user:      activity_user
  )
end

def build_case()
  # Ref number format is canonical in Canton de Vaud
  ref_no = ('A'..'Z').to_a.sample(2).join + (12..21).to_a.sample.to_s + "." + (000000..999999).to_a.sample.to_s + "-" + ('A'..'Z').to_a.sample(3).join
  Project.create!(
    label:       LEGALESE.shuffle.pop,
    description: [Faker::Hipster.paragraph, nil][weighted_random(0.5)],
    status:      rand(0..1),
    category:    ProjectCategory.all.sample,
    clients:     Contact.clients.sample(rand(1...3)),
    adversaries: Contact.adversaries.sample(rand(0...5)),
    reference:   [ref_no.to_s, nil].sample,
    owner:       User.partners.sample
  )
end

def build_contact()
  company = [true, false][weighted_random()];
  Contact.create!(
    name:       company ? Faker::Company.name : "#{ Faker::Name.first_name } #{ Faker::Name.last_name }",
    activity:   company ? Faker::Company.industry : Faker::Company.profession.capitalize,
    email:      Faker::Internet.unique.email,
    street:     "#{ Faker::Address.street_name } #{ [nil, Faker::Address.building_number][weighted_random()] }",
    city:        "#{ Faker::Address.zip_code } #{ Faker::Address.city }",
    country:    ["Switzerland", Faker::Address.country][weighted_random()],
    category:   company ? 1 : 0,
    notes:      [nil, Faker::Hipster.sentence][weighted_random()],
    role:       ContactRole.all.sample
  )
end

def build_contact_role(arr)
  ContactRole.create!(
    label: arr[0],
    color: arr[1]
  )
end

def build_deadline
  Deadline.create!(
    label:        Faker::Company.bs.capitalize,
    category:     Deadline::CATEGORIES.sample,
    date:         Faker::Date.forward(days: 120),
    completed_at: [Faker::Time.backward(days: 14), nil][weighted_random(0.8)],
    project:      Project.all.sample,
    assignee:     User.lawyers.sample
  )
end

def build_project_category(arr)
  ProjectCategory.create!(
    label: arr[0],
    color: arr[1]
  )
end

def build_user(role = nil)
  user = User.create!(
    login:       role.nil? ? Faker::Internet.username : "#{role[0]}@test.dev",
    name:        "#{ Faker::Name.first_name } #{ Faker::Name.last_name }",
    email:       Faker::Internet.unique.email,
    password:    "password",
    avatar:      "fallback_avatars/#{AVATARS[rand(1...10)].split('/').last}",
    locale:      ['en', 'fr'].sample,
    role:        role.nil? ? rand(0..2) : role[1],
    default_fee: 150 * rand(1..4)
  )
  puts "   Generated user '#{user.login}' (#{user.role.capitalize})"
end

def weighted_random(float = 0.8)
  float <= rand(0.0..1.0) ? 0 : 1
end

puts "   Generating contact roles..."
ContactRole::ROLES.each do |e|
  build_contact_role(e)
end
puts "✓  Successfully generated #{ContactRole.all.count} contact roles"

puts "   Generating one user per role..."
User.roles.each do |e|
  build_user(e)
end
puts "✓  Successfully generated #{User.all.count} users"

puts "   Generating additional users..."
6.times do
  build_user()
end
puts "✓  Successfully generated a total of #{User.all.count} users"

puts "   Generating project categories..."
ProjectCategory::CATEGORIES.each do |e|
  build_project_category(e)
end
puts "✓  Successfully generated #{ProjectCategory.all.count} project categories"

puts "   Generating contacts..."
rand(rand_min...rand_max).times do |i|
  build_contact()
  puts "   already generated #{i} contacts, still more to go..." if i % 100 == 0 && i > 0
end
puts "✓  Successfully generated #{Contact.all.count} contacts"

puts "   Generating cases..."
rand(rand_min...rand_max).times do |i|
  build_case()
  puts "   already generated #{i} cases, still more to go..." if i % 100 == 0 && i > 0
end
puts "✓  Successfully generated #{Project.all.count} cases"

puts "   Generating activities..."
rand((rand_min * 5)...(rand_max * 5)).times do |i|
  build_activity()
  puts "   already generated #{i} activities, still more to go..." if i % 100 == 0 && i > 0
end
puts "✓  Successfully generated #{Activity.all.count} activities"

puts "   Generating deadlines..."
rand((rand_min * 2)...(rand_max * 2)).times do |i|
  build_deadline()
end
puts "✓  Successfully generated #{Deadline.all.count} deadlines"
