require 'test_helper'

class My::ProjectFlowsTest < ActionDispatch::IntegrationTest

	setup do
    Capybara.current_driver = Capybara.javascript_driver
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

  test "navigation" do
  	visit '/'

  	# click on 'My Projects'
  	find('.navbar').click_link("My Projects")
  	assert_equal my_projects_path, current_path

  	# 'My Projects' should have class '.active' on my_projects_path and
  	#    and should be the only active element
  	assert_equal "My Projects", find('.navbar ul li.active a').text
		assert_selector '.navbar ul li.active a', count: 1

  	# click on 'New Project'
  	click_link "New Project"
  	assert_equal new_my_project_path, current_path

  	# make sure 'My Projects' is still active
  	assert_equal "My Projects", find('.navbar ul li.active a').text
  end

  test "can delete my project" do
    page.driver.accept_js_confirms!
    
    project = FactoryGirl.create(:project, user: @me)

    visit my_projects_path

    # project should get created and assigned to 'me'
    assert_equal 1, @me.projects.count

    assert_selector 'div.project'

    # project info should be in a class 'project'
    assert_selector '.project', count: 1
    
    # click an individual project 
    click_link project.title

    print page.html

    click_link "Edit Project"
    assert_equal edit_my_project_path(project), current_path
    
    click_button "Delete Project"
    
    # project should no longer exist/be visible on the index
    assert_selector(".project", count: 0)  
  end
end

