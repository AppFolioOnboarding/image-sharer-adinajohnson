require 'test_helper'

class ImagesControllerTest < ActionDispatch::IntegrationTest
  def test_new
    get new_image_path
    assert_response :ok
    assert_select '#header', 'Enter an image url'
  end

  def test_create__succeed
    assert_difference('Image.count', 1) do
      image_params = { url: 'https://pbs.twimg.com/profile_images/962170088941019136/lgpCD8X4_400x400.jpg' }
      post images_path, params: { image: image_params }
    end

    assert_redirected_to image_path(Image.last)
    assert_equal 'Image was successfully created.', flash[:notice]
  end

  def test_create__fail
    assert_no_difference('Image.count') do
      image_params = { url: 'es/962170088941019136/lgpCD8X4_400' }
      post images_path, params: { image: image_params }
    end

    assert_response :unprocessable_entity
  end
end
