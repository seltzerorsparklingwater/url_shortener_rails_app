# == Schema Information
#
# Table name: users
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  email      :string           not null
#

class User < ApplicationRecord
    validates :email, presence: true
    validates :email, uniqueness: true

    has_many :submitted_urls,
        primary_key: :id,
        foreign_key: :submitter_id,
        class_name: :ShortenedUrl 

    has_many :visits,
        primary_key: :id,
        foreign_key: :user_id,
        class_name: :Visit

    # To de-duplicate the results, uncomment the lambda below.
    has_many :visited_urls,
        # -> { distinct },
        through: :visits,
        source: :shortened_url
    
end
