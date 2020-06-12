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
require 'rails_helper'

RSpec.describe Forest, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
