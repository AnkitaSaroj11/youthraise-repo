class AddSessionIdToSupporters < ActiveRecord::Migration[7.0]
  def change
    add_column :supporters, :stripe_session_id, :string
  end
end
