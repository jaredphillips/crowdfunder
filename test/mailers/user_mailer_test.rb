require 'test_helper'

class UserMailerTest < ActionMailer::TestCase

	test "new pledge" do
		project = FactoryGirl.create(:project)
		pledge = FactoryGirl.create(:pledge, project: project)
		backer = pledge.user

		email = UserMailer.new_pledge(backer, project, pledge).deliver
		# backer email is the same as email.to
		assert_equal [backer.email], email.to
		
		# make sure we have the right subject
		assert_equal "You have backed a project", email.subject

		# find the amount of the pledge somewhere in the body of the email
		assert_match pledge.amount.to_s, email.body.to_s
	end
end
