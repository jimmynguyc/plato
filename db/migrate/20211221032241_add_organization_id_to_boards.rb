class AddOrganizationIdToBoards < ActiveRecord::Migration[7.0]
  def change
    add_column :boards, :organization_id, :integer
    add_index :boards, :organization_id
  end
end
