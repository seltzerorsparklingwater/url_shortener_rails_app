# == Schema Information
#
# Table name: shortened_urls
#
#  id           :bigint           not null, primary key
#  short_url    :string           not null
#  long_url     :string           not null
#  submitter_id :integer          not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class ShortenedUrl < ApplicationRecord
    validates :long_url, :short_url, :submitter, presence: true
    validates :short_url, uniqueness: true

    belongs_to :submitters,
        primary_key: :id,
        foreign_key: :submitter_id,
        class_name: :User






    def self.create_for_user_and_long_url!(user, long_url)
        ShortenedUrl.create!(
            submitter_id: user.id,
            long_url: long_url,
            short_url: ShortenedUrl.random_code
        )
    end

    def self.random_code
        loop do
            random_code = SecureRandom.urlsafe_base64(16)
            return random_code unless ShortenedUrl.exists?(short_url: random_code)
        end
    end

end
