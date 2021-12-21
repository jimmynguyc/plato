# == Schema Information
#
# Table name: lanes
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  board_id   :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Lane < ApplicationRecord
  belongs_to :board
  has_many :cards, dependent: :destroy

  broadcasts_to ->(lane) { [lane.board, :lanes] }, target: ->(lane) { "board_#{lane.board.id}_lanes" }
end
