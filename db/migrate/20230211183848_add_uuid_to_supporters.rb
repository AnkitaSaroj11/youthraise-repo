class AddUuidToSupporters < ActiveRecord::Migration[7.0]
  def change
    add_column :supporters, :uuid, :string
    add_index :supporters, :uuid
  end
end
