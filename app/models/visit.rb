# == Schema Information
#
# Table name: visits
#
#  id               :bigint           not null, primary key
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  user_id          :integer          not null
#  shortened_url_id :integer          not null
#

class Visit < ApplicationRecord
    validates :visitor, :shortened_url, presence: true

end
