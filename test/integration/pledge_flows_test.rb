require 'test_helper'

class PledgeFlowsTest < ActionDispatch::IntegrationTest
	setup do
		@project = FactoryGirl.create(:project)
	end

	test "requires authenticated user" do
		visit project_path(@project)

		# navigate to login page if not logged in
		click_link "Support this project!"
		assert_equal login_path, current_path

		# see alert message explaining how you got there
		assert_equal "You must login to pledge!", find('.alert').text
	end

	test "authenticated user can pledge valid amount" do
		user = setup_signed_in_user

		visit project_path(@project)

		# navigate to new pledge page if logged in
		click_link "Support this project!"
		assert_equal new_project_pledge_path(@project), current_path

		# pledge count should be 0
		assert_equal 0, @project.pledges.count

		# after filling in amount and submitting, user is directed to project page
		#   and see message
		fill_in "pledge[amount]", with: 100
		click_button "Pledge now!"
		assert_equal project_path(@project), current_path
		assert_equal "Thanks for supporting this project!", find('.notice').text

		# verify the pledge was created with the right attributes
		pledge = @project.pledges.last
		assert_equal user, pledge.user
		assert_equal @project, pledge.project
		assert_equal 100, pledge.amount

		# testing that an email should be delivered to a project owner
		assert_equal [@project.user.email], last_email.to   
	end
end
