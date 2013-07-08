# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.destroy_all
Project.destroy_all

user = User.create!(first_name: "Example", last_name: "User", email: "example@email.com", password: "12345678")

project1 = user.projects.create!(title: "Project 1", teaser: "Teaser text 1",
  description: "Description 1", goal: 13000)

project2 = user.projects.create!(title: "Project 2", teaser: "Teaser text 2",
  description: "Description 2", goal: 210000)

project2 = user.projects.create!(title: "Project 3", teaser: "Teaser text 3",
  description: "Description 3", goal: 30000)