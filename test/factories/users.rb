# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
  	first_name "Jared"
  	last_name "Phillips"
  	sequence(:email) { |n| "jared#{n}@email.com" }
  	password "12345678"
  end
end
