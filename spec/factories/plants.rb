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
FactoryBot.define do
  factory :plant do
    name { "MyString" }
    common_name { "MyString" }
  end
end
