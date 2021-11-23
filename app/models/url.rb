class Url < ApplicationRecord
    validates :url_name,:long_url, presence: true, uniqueness: { case_sensitive: false }
    validates :url_name, length: {minimum: 5}
    validates :long_url, length: {minimum: 40}
    before_create :generate_short_url

    def generate_short_url
        rand(36**8).to_s(36)
    end
end
