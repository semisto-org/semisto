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
require 'rails_helper'

RSpec.describe Plant, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
