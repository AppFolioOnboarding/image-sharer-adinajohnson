class Image < ApplicationRecord
  validates :url, presence: true
  validate :url_must_be_valid

  acts_as_taggable

  private

  def url_must_be_valid
    uri = URI.parse(url)
    errors.add(:url, 'must be valid') unless uri.is_a?(URI::HTTP) || uri.is_a?(URI::HTTPS)
  end
end
