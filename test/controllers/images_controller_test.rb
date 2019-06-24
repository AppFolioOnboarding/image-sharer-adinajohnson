require 'test_helper'

class ImagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @image = Image.create!(
      url: 'https://pbs.twimg.com/profile_images/962170088941019136/lgpCD8X4_400x400.jpg',
      tag_list: 'dog, woof, pup'
    )
  end

  def test_show
    get image_path(@image.id)
    assert_response :ok
    assert_select '#header', 'This is your image'
    assert_select '#js-tags' do |tags|
      assert_equal 'dog woof pup', tags.text.squish
    end
    assert_select 'a[href=?]', image_path(@image),
                  text: 'DESTROY!!!!!!!',
                  method: :destroy,
                  data:   { confirm: 'Are you sure?' }
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
    assert_equal Image.last.tag_list, %w[dog woof pup]
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
    assert_select '.js-tags' do |tags|
      assert_equal 'dog woof pup', tags.text.squish
    end
  end

  def test_index_tag_filtering
    Image.create!(url: 'https://pbs.twimg.com/profile_images/962170088941019136/lgpCD8X4_400x400.jpg',
                  tag_list: 'dog, pup')
    get images_path

    assert_select 'img', count: 2

    get images_path(tag: 'woof')

    assert_select 'img', count: 1
  end

  def test_index_redirect_to_show
    @image2 = Image.create!(url: 'https://', tag_list: 'dog, pup')
    get images_path

    assert_select 'a[href=?]', "/images/#{@image.id}"
    assert_select 'a[href=?]', "/images/#{@image2.id}"
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

  def test_destroy
    assert_difference('Image.count', -1) do
      delete image_path(@image.id)
    end

    assert_redirected_to images_path
    assert_equal 'Image was successfully deleted.', flash[:notice]

    get images_path

    assert_select 'img', count: 0
  end
end
