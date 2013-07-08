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
    assert page.has_content?('Account Created')

    # navbar doesn't have a link to sign up but log out
    assert find('.navbar').has_link?('Log Out')

    assert find('.navbar').has_no_link?('Sign up')
	end

	test "failed registration" do
    visit "/users/new"

    user = FactoryGirl.build(:user)
    fill_in "user[email]", with: user.email
    click_button "Create Account"
		# redirect to users / new path 
		assert_equal new_user_path, current_path
		assert page.has_no_content?('Account Created')
	end
end
