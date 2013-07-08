# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :project do
  	user
  	title "Star Wars"
  	teaser "Awesome Movie"
  	description "Fighting in space and shit"
  	goal 10000000
  end
end
