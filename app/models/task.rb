# == Schema Information
#
# Table name: tasks
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  completed  :boolean          default("0")
#  card_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Task < ApplicationRecord
  belongs_to :card

  broadcasts_to ->(task) { [task.card, :tasks] }, target: ->(task) { "card_#{task.card.id}_tasks" }
end
