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

yellow_submarine = Project.create!(name: "Yellow Submarine", users: [john, paul])
hey_jude         = Project.create!(name: "Hey Jude!",        users: [john, paul])
dont_pass_me_by  = Project.create!(name: "Don't pass me by", users: [ringo])
