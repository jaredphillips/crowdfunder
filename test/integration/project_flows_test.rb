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
		# create a project to visit its show page
		project1 = FactoryGirl.create(:project, :title => "Project 1")

		visit "/"
		assert_equal root_path, current_path

		# .navbar should contain "Home"
		assert_equal "Home", find('.navbar ul li.active a').text

		# .navbar should contain a link "Projects"
		find('.navbar ul').click_link("Projects")
		assert_equal projects_path, current_path

		# "Projects" should be active on the projects_path
		assert_equal "Projects", find('.navbar ul li.active a').text

		# make sure only one element remains active
		page.assert_selector '.navbar ul li.active a', count: 1

		click_link "Project 1"

		# "Projects" should remain active when on a project's show page
		assert_equal "Projects", find('.navbar ul li.active a').text
	end

	test "pagination" do
		user = FactoryGirl.create(:user)

		50.times do |i|
			Project.create!(
				title: "Star Wars Part #{RomanNumerals.to_roman(i + 7)}",
				teaser: "Teaser Part #{RomanNumerals.to_roman(i + 7)}",
				description: "Description Part #{RomanNumerals.to_roman(i + 7)}",
				goal: (14761994 * (i + 1)),
			)
		end

		visit '/projects'

		# expect the most recent projects on page 1 (8 per page)
		assert page.has_content?("Star Wars Part L")
		assert page.has_no_content?("Star Wars Part IIL")
		page.assert_selector '.project', count: 8

		# click to go to page 2
		page.find('.pagination').click_link "2"
		assert_equal paginated_projects_path(page: 2), current_path

		assert page.has_content?("Star Wars Part XLIII")
		assert page.has_no_content?("Star Wars Part L")
	end
end