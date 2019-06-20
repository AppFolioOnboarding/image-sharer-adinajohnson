require 'test_helper'

class ImageTest < ActiveSupport::TestCase
  def test_image__valid
    url_cases = [
      'https://pbs.twimg.com/profile_images/962170088941019136/lgpCD8X4_400x400.jpg',
      'https://',
      'https:sdf',
      'http:'
    ]
    url_cases.each do |url|
      image = Image.new(url: url)
      assert_predicate image, :valid?
    end
  end

  def test_url__invalid_if_url_is_blank
    image = Image.new(url: '')
    assert_not_predicate image, :valid?
    assert_equal "can't be blank", image.errors.messages[:url].first
  end

  def test_url__invalid_if_url_is_not_valid
    image = Image.new(url: 'sdfdsgsfd')

    assert_not_predicate image, :valid?
    assert_equal 'must be valid', image.errors.messages[:url].first
  end
end
