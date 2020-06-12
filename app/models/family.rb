# == Schema Information
#
# Table name: families
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Family < ApplicationRecord
end
