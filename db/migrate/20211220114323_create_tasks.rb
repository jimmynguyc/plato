class CreateTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks do |t|
      t.string :title
      t.boolean :completed, default: false
      t.references :card, null: false, foreign_key: true

      t.timestamps
    end
  end
end
