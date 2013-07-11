require 'test_helper'

class My::ImageFlowsTest < ActionDispatch::IntegrationTest
  setup do
  	@me = setup_signed_in_user
  	@project = FactoryGirl.create(:project, user: @me)
  end

  test "user can upload picture to his/her project" do
  	visit edit_my_project_path(@project)

  	# should have an upload photo link
  	assert has_link? "Manage Images"

  	click_link "Manage Images"

  	# make sure we start with no images
  	assert_no_selector '.project-img'

    # click a link called new image
    click_link "New Image"

    assert_equal new_my_project_image_path(@project), current_path

  	# grab the image to be uploaded
  	image_path = File.join(Rails.root, 'app', 'assets', 'images', 'rails.png')

  	# not sure
  	attach_file("image[image]", image_path)

  	click_button "Upload photo"

    assert_equal 1, @project.images.count
    assert_equal my_project_images_path(@project), current_path

  	# should have 1 photo now
  	assert_selector('.project-img', count: 1)
  end

  test "failing upload of an image to a project" do
    visit my_project_images_path(@project)

  	click_link "New Image"
    
    image_path = File.join(Rails.root, 'app', 'assets', 'images', 'rails.txt')

  	attach_file("image[image]", image_path)
  	click_button "Upload photo"

  	# correct error flashed
  	assert_equal "Sorry, attachment must be an image.", find('.error').text

  	# no images isn't visible
  	assert_no_selector '.project-img'
	end
end
