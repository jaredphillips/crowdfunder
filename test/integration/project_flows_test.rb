require 'test_helper'

class ProjectFlowsTest < ActionDispatch::IntegrationTest
	
	test "browsing projects" do
		project1 = FactoryGirl.create(:project, title: "Project 1")
		project2 = FactoryGirl.create(:project, title: "Project 2")
		project3 = FactoryGirl.create(:project, title: "Project 3")

		visit "/projects"

		assert_equal projects_path, current_path

		assert page.has_content?('All projects')

		assert page.has_content?('Project 1')
		assert page.has_content?('Project 2')
		assert page.has_content?('Project 3')	

		click_link('Project 1') 

		assert_equal project_path(project1), current_path

		# make sure first h1 has content equal to project 1 title
		assert_equal project1.title, find('h1:first').text
	end

	test "navigation" do
		visit "/"

		assert_equal root_path, current_path

		assert_equal "Home", find('.navbar ul li.active a').text

		find('.navbar ul').click_link("Projects")

		assert_equal projects_path, current_path

		assert_equal "Projects", find('.navbar ul li.active a').text
	end
	
end
