require 'test_helper'

class My::ProjectFlowsTest < ActionDispatch::IntegrationTest

	setup do
		@me = setup_signed_in_user
		@other_user = FactoryGirl.create(:user)
	end

	test "lists only my projects" do
		3.times do
			FactoryGirl.create(:project, user: @me)
		end

		2.times do
			FactoryGirl.create(:project, user: @other_user, title: "Other Dude's Project")
		end

		visit '/my/projects'
		page.assert_selector('div.project', count: 3)

		# make sure page does not have Other Dudes Project on it
		assert page.has_no_content?("Other Dude's Project")
	end

	test "can edit my project" do
		project = FactoryGirl.create(:project, user: @me, title: "My project")

		visit edit_my_project_path(project)

		fill_in "project[title]", with: "It is really my project"
		click_button "Update project"

		assert_equal my_projects_path, current_path

		assert has_content?("It is really my project")
	end

	test "cannot edit someone elses project" do
		project = FactoryGirl.create(:project, user: @other_user, title: "Other Users Project")

		visit edit_my_project_path(project)

		assert_equal projects_path, current_path

		assert has_content?("You cannot edit other users' projects")
  end

  test "successful creation of project makes it public right away" do
  	project = FactoryGirl.build(:project, user: @me)
  	visit	'/my/projects/new'
  	fill_in "project[title]", with: "My Title"
  	fill_in "project[teaser]", with: "Heres the teaser"
  	fill_in "project[description]", with: "Sports, sports, sports"
  	fill_in "project[goal]", with: 10000000
  	click_button "Create Project"

  	assert_equal my_projects_path, current_path

  	assert page.has_content?("My Title")
  end
end

