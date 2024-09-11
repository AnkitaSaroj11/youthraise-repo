class AddTypeToDeliveryAttempt < ActiveRecord::Migration[7.0]
  def change
    add_column :delivery_attempts, :deliverable_type, :string
    rename_column :delivery_attempts, :supporter_id, :deliverable_id
    add_index :delivery_attempts, [:deliverable_type, :deliverable_id]
  end
end
