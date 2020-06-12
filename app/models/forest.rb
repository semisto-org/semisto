# == Schema Information
#
# Table name: forests
#
#  id          :bigint           not null, primary key
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  latitude    :decimal(, )
#  longitude   :decimal(, )
#  drawn_items :jsonb
#
class Forest < ApplicationRecord
  has_many :plants
end
