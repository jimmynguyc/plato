# == Schema Information
#
# Table name: organizations
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  plan       :string(255)
#

class Organization < ApplicationRecord
  has_many :users
  has_many :boards
end
