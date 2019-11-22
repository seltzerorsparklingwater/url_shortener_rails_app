class Tagging < ApplicationRecord

    belongs_to :tag_topic,
        primary_key: :id,
        foreign_key: :tag_topic_id,
        class_name: :tag_topic

    belongs_to :shortened_url,
        primary_key: :id,
        foreign_key: :shortened_url_id,
        class_name: :ShortenedUrl 

    def popular_links
        shortened_urls.joins(:visits)
        .group(:short_url, :long_url)
        .order('COUNT(visits.id) DESC')
        .select('long_url, short_url, COUNT(visits.id) as number_of_visits')
        .limit(5)
    end

end
