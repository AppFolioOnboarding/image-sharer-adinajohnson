require 'test_helper'

class ImagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @image = Image.create!(url: 'https://pbs.twimg.com/profile_images/962170088941019136/lgpCD8X4_400x400.jpg', tag_list: 'dog, woof, pup')
  end

  def test_show
    get image_path(@image.id)
    assert_response :ok
    assert_select '#header', 'This is your image'
  end

  def test_new
    get new_image_path
    assert_response :ok
    assert_select '#header', 'Enter an image url'
    assert_select 'label', 'Tag list'
  end

  def test_create__succeed
    assert_difference('Image.count', 1) do
      image_params = {
        url: 'https://pbs.twimg.com/profile_images/962170088941019136/lgpCD8X4_400x400.jpg',
        tag_list: 'dog, woof, pup'
      }

      post images_path, params: { image: image_params }
    end

    assert_redirected_to image_path(Image.last)
    assert_equal 'Image was successfully created.', flash[:notice]
    assert_equal Image.last.tag_list, ['dog', 'woof', 'pup']
  end

  def test_create__fail
    assert_no_difference('Image.count') do
      image_params = { url: 'es/962170088941019136/lgpCD8X4_400' }
      post images_path, params: { image: image_params }
    end

    assert_response :unprocessable_entity
  end

  def test_index
    get images_path

    assert_response :ok
    assert_select '#header', 'These are your images'
    assert_select 'img', count: 1
    assert_select 'img[src=?]', 'https://pbs.twimg.com/profile_images/962170088941019136/lgpCD8X4_400x400.jpg'
  end

  def test_index_order
    @image.destroy
    urls = ['http://', 'https://', 'http://i']
    urls.each do |url|
      Image.create!(url: url)
    end
    urls = urls.reverse

    get images_path

    assert_select 'img', count: 3
    assert_select 'img' do |images|
      images.each_with_index do |image, idx|
        assert_equal image.attribute('src').value, urls[idx]
      end
    end
  end
end
