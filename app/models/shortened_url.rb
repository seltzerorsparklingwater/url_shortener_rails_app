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

    belongs_to :submitter,
        primary_key: :id,
        foreign_key: :submitter_id,
        class_name: :User

    has_many :visits,
        primary_key: :id,
        foreign_key: :shortened_url_id,
        class_name: :Visit,
        dependent: :destroy

    # may uncomment the proc below to eliminate duplicates in the result set.
    has_many :visitors,
        Proc.new { distinct },
        through: :visits,
        source: :visitor

    has_many :taggings,
        primary_key: :id,
        foreign_key: :shortened_url_id,
        class_name: :Tagging,
        dependent: :destroy

    has_many :tag_topics,
        through: :taggings,
        source: :tag_topic

    #factory method must be called on the ShortenedUrl class not the instance
    #e.g. ShortenedUrl.self.create_for_user_and_long_url(User.first, "www.yolo.com")
    def self.create_for_user_and_long_url!(user, long_url)
        ShortenedUrl.create!(
            submitter_id: user.id,
            long_url: long_url,
            short_url: ShortenedUrl.random_code
        )
    end

    #helper method; not intended to be called alone
    def self.random_code
        loop do
            random_code = SecureRandom.urlsafe_base64(16)
            return random_code unless ShortenedUrl.exists?(short_url: random_code)
        end
    end

    def num_clicks
        visits.count
    end

    def num_uniques
        visits.select('user_id').distinct.count
    end

    def num_recent_uniques
        visits
            .select('user_id')
            .where('created_at > ?', 10.minutes.ago)
            .distinct
            .count
    end

end
