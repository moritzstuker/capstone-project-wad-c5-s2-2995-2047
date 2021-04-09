# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

admin  = User.create!(login: "admin@test.dev",  firstname: "Yogi",   lastname: "Maharishi Mahesh", password: "password", role: "admin")
john   = User.create!(login: "john@test.dev",   firstname: "John",   lastname: "Lennon",           password: "password", role: "partner")
paul   = User.create!(login: "paul@test.dev",   firstname: "Paul",   lastname: "McCartney",        password: "password", role: "associate")
george = User.create!(login: "george@test.dev", firstname: "George", lastname: "Harrison",         password: "password", role: "client")
ringo  = User.create!(login: "ringo@test.dev",  firstname: "Ringo",  lastname: "Starr",            password: "password", role: "client")

yellow_submarine = Project.create!(name: "Yellow Submarine", owner: john,   users: [john, paul])
hey_jude         = Project.create!(name: "Hey Jude!",        owner: paul,   users: [john, paul])
dont_pass_me_by  = Project.create!(name: "Don't pass me by", owner: george, users: [ringo])

te1 = TimeEntry.create!(label: "Some label",       date: DateTime.new(2021,03,03), time: 0.2, project: dont_pass_me_by, user: ringo)
te2 = TimeEntry.create!(label: "Some other label", date: DateTime.new(2021,03,02), time: 0.4, project: yellow_submarine, user: paul)
te3 = TimeEntry.create!(label: "Some label",       date: DateTime.new(2021,03,01), time: 0.8, project: hey_jude, user: john)
te4 = TimeEntry.create!(label: "Some other label", date: DateTime.new(2021,03,04), time: 1.4, project: dont_pass_me_by, user: ringo)
te5 = TimeEntry.create!(label: "Some other label", date: DateTime.new(2021,03,02), time: 6.7, project: hey_jude, user: paul)

contact1 = Contact.create!(firstname: "Joe",    lastname: "Strummer", phone: "+41 79 123 45 67", email: "some_address@hotmail.com", address: "Address")
contact2 = Contact.create!(firstname: "Mick",   lastname: "Jones",    phone: "+41 79 123 45 67", email: "some_address@hotmail.com", address: "Address")
contact3 = Contact.create!(firstname: "Paul",   lastname: "Simonon",  phone: "+41 79 123 45 67", email: "some_address@hotmail.com", address: "Address")
contact4 = Contact.create!(firstname: "Keith",  lastname: "Levene",   phone: "+41 79 123 45 67", email: "some_address@hotmail.com", address: "Address")
contact5 = Contact.create!(firstname: "Terry",  lastname: "Chimes",   phone: "+41 79 123 45 67", email: "some_address@hotmail.com", address: "Address")
contact5 = Contact.create!(firstname: "Topper", lastname: "Headon",   phone: "+41 79 123 45 67", email: "some_address@hotmail.com", address: "Address")
