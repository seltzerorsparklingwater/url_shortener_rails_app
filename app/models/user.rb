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

    has_many :shortened_url,
        primary_key: :id,
        foreign_key: :submitter_id,
        class_name: :ShortenedUrl 


    
end
