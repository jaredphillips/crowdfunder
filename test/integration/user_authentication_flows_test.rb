require 'test_helper'

class UserAuthenticationFlowsTest < ActionDispatch::IntegrationTest

	test "successful registration" do
		visit "/users/new"
		assert_equal new_user_path, current_path

		#assert link in nav bar to sign up
		assert_equal "Sign up", find('.navbar ul li.active a').text

		user = FactoryGirl.build(:user)
		# fill in form with the info from user
		fill_in "user[email]", with: user.email
		fill_in "user[first_name]", with: user.first_name
		fill_in "user[last_name]", with: user.last_name
		fill_in "user[password]", with: user.password

		click_button "Create Account"
		# user should be redirected to root 
		assert root_path, current_path
		
		# and a message should flash message 'account created'
		assert_equal "Account Created!", find('.notice').text

		# # navbar doesn't have a link to sign up but log out
		# assert find('.navbar').has_link?('Log Out')

		# assert find('.navbar').has_no_link?('Sign up')
	end

	test "failed registration" do
		visit "/users/new"

		user = FactoryGirl.build(:user)
		fill_in "user[email]", with: user.email
		click_button "Create Account"

		# redirect to users / new path 
		assert_equal users_path, current_path
		assert page.has_no_content?('Account Created!')

		# should see try again message on failure to register
		assert_equal "Try again!", find('.alert').text
	end

	test "successful login" do

		visit '/'

		# make sure nav bar does not have link 'log out'
		assert find('.navbar').has_no_link?("Log Out")

		# set up signed in user 
		user = setup_signed_in_user

		# flashes correct messages
		assert_equal "Welcome back!", find('.notice').text

		# make sure link for log out exists
		assert find('.navbar').has_link?("Log Out")
	end

	test "failed log in" do

		visit '/login'

		# fill in email with wrong email
		fill_in "email", with: "wrong@email.com"

		click_button "Login"
		assert_equal sessions_path, current_path
		
		# make sure page says invalid?
		assert_equal "Email or password not found", find('.error').text
	end

	test "successful log out" do
		Capybara.current_driver = Capybara.javascript_driver

		user = setup_signed_in_user

		visit '/'
		# click log out in navbar 
		find('.navbar').click_link("Log Out")
		# make sure page has "Bye!"
		assert_equal "Bye!", find('.notice').text
		assert find('.navbar').has_no_link?("Log Out")
	end

end
