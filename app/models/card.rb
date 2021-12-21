# == Schema Information
#
# Table name: cards
#
#  id          :integer          not null, primary key
#  title       :string(255)
#  description :text(65535)
#  lane_id     :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Card < ApplicationRecord
  belongs_to :lane
  has_many :tasks, dependent: :destroy

  broadcasts_to ->(card) { [card.lane, :cards] }, target: ->(card) { "lane_#{card.lane.id}_cards" }

  def completed?
    tasks.all?(&:completed?)
  end
end
