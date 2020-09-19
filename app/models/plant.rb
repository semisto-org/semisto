# == Schema Information
#
# Table name: plants
#
#  id          :bigint           not null, primary key
#  name        :string
#  common_name :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  forest_id   :bigint           not null
#
class Plant < ApplicationRecord
  belongs_to :forest

  validates :common_name, presence: true
end
