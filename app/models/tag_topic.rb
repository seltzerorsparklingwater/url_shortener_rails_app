class TagTopic < ApplicationRecord

    has_many :taggings,
        primary_key: :id,
        foreign_key: :tag_topic,
        class_name: :Tagging,
        dependent: :destroy

    has_many :shortened_Urls,
        through: :taggings,
        source: :shortened_url

end
