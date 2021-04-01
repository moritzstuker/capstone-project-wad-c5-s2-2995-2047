# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

admin  = User.create!(username: 'admin@test.dev',  name: 'Admin',  password: 'password', role: 'admin')
john   = User.create!(username: 'john@test.dev',   name: 'John',   password: 'password', role: 'partner')
paul   = User.create!(username: 'paul@test.dev',   name: 'Paul',   password: 'password', role: 'associate')
george = User.create!(username: 'george@test.dev', name: 'George', password: 'password', role: 'client')
ringo  = User.create!(username: 'ringo@test.dev',  name: 'Ringo',  password: 'password', role: 'client')
