# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

contact1  = Contact.create!(firstname: "Bernie", lastname: "Rhodes",   phone: "+41 79 123 45 67", email: "bernie.rhodes@test.dev", address: "Avenue du Lac 13, 1006 Lausanne")
contact2  = Contact.create!(firstname: "Joe",    lastname: "Strummer", phone: "+41 79 890 12 34", email: "joe.strummer@test.dev",  address: "Rue du Centre 22, 1800 Vevey")
contact3  = Contact.create!(firstname: "Mick",   lastname: "Jones",    phone: "+41 79 567 89 01", email: "mick.jones@test.dev",    address: "Chemin de Courbet 18, 1110 Morges")
contact4  = Contact.create!(firstname: "Paul",   lastname: "Simonon",  phone: "+41 79 234 56 78", email: "paul.simonon@test.dev",  address: "11 Rue du Président Carnot, 69002 Lyon, France")
contact5  = Contact.create!(firstname: "Keith",  lastname: "Levene",   phone: "+41 79 901 23 45", email: "keith.levene@test.dev",  address: "Place de l'Atomium 1, 1020 Bruxelles, Belgique")
contact6  = Contact.create!(firstname: "Terry",  lastname: "Chimes",   phone: "+41 79 678 90 12", email: "terry.chimes@test.dev",  address: "Bundesplatz 3, 3005 Bern")
contact7  = Contact.create!(firstname: "Topper", lastname: "Headon",   phone: "+41 79 345 67 89", email: "topper.headon@test.dev", address: "Quai Gustave-Ador, 1207 Genève")
contact8  = Contact.create!(firstname: "Pete",   lastname: "Howard",   phone: "+41 79 012 34 56", email: "pete.howard@test.dev",   address: "Rue du Théâtre 9, 1820 Montreux")
contact9  = Contact.create!(firstname: "Nick",   lastname: "Sheppard", phone: "+41 79 789 01 23", email: "nick.sheppard@test.dev", address: "Rue du Centre 22, 1800 Vevey")
contact10 = Contact.create!(firstname: "Vince",  lastname: "White",    phone: "+41 79 456 78 90", email: "vince.white@test.dev",   address: "Rue du vingt-trois Juin 52, 2800 Delémont")

user1 = User.create!(login: contact1.email, password: "password", avatar: "", permissions: "admin",     contact: contact1)
user2 = User.create!(login: contact2.email, password: "password", avatar: "", permissions: "partner",   contact: contact2)
user3 = User.create!(login: contact3.email, password: "password", avatar: "", permissions: "associate", contact: contact3)
user4 = User.create!(login: contact4.email, password: "password", avatar: "", permissions: "associate", contact: contact4)
user5 = User.create!(login: contact5.email, password: "password", avatar: "", permissions: "associate", contact: contact5)

project1 = Project.create!(name: "London calling",                owner: user2, users: [user1, user2, user3], description: "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.")
project2 = Project.create!(name: "Rock the casbah",               owner: user2, users: [user2, user3, user4], description: "Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.")
project3 = Project.create!(name: "The Magnificent Seven",         owner: user2, users: [user5],               description: "Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.")
project4 = Project.create!(name: "Should I stay or should I go?", owner: user3, users: [user4, user5],        description: "Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.")
project5 = Project.create!(name: "If music could talk",           owner: user4, users: [user2, user5],        description: "Curabitur pulvinar enim sed pulvinar scelerisque.")

time_entry1 = TimeEntry.create!(label: "Email to client",          date: DateTime.new(2021,03,03), time: 0.2, project: project1, user: user2)
time_entry2 = TimeEntry.create!(label: "Meeting with client",      date: DateTime.new(2021,03,03), time: 2.2, project: project1, user: user2)
time_entry3 = TimeEntry.create!(label: "Visited client in prison", date: DateTime.new(2021,03,05), time: 4.2, project: project2, user: user4)
time_entry4 = TimeEntry.create!(label: "Phone call with client",   date: DateTime.new(2021,03,04), time: 5.6, project: project2, user: user4)
time_entry5 = TimeEntry.create!(label: "Research",                 date: DateTime.new(2021,03,07), time: 0.4, project: project2, user: user3)
