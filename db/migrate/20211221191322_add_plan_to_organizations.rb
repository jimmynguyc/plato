class AddPlanToOrganizations < ActiveRecord::Migration[7.0]
  def change
    add_column :organizations, :plan, :string
  end
end
