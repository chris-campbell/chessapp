class AddPlayerToPieces < ActiveRecord::Migration[5.0]
  def change
    add_column :pieces, :player, :integer
  end
end
