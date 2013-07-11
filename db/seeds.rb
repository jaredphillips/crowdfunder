# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.destroy_all
Project.destroy_all

me = User.create!(first_name: "Example", last_name: "User", email: "example@email.com", password: "12345678")
other_guy = User.create!(first_name: "Other", last_name: "User", email: "other_user@email.com", password: "12345678")

50.times do |i|
	Project.create!(
		title: "Star Wars Part #{RomanNumerals.to_roman(i + 7)}",
		teaser: "Teaser Part #{RomanNumerals.to_roman(i + 7)}",
		description: "Description Part #{RomanNumerals.to_roman(i + 7)}",
		goal: (14761994 * (i + 1)),
		user: me
	)
end