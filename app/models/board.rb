# == Schema Information
#
# Table name: boards
#
#  id              :integer          not null, primary key
#  user_id         :integer          not null
#  title           :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  organization_id :integer
#

class Board < ApplicationRecord
  belongs_to :user
  belongs_to :organization, optional: true
  has_many :lanes, dependent: :destroy

  broadcasts_to ->(board) { [board.user, :boards] }

  before_create do
    self.organization = user.organization if user.organization
  end
end
