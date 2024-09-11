class AddSendToMembersToMessages < ActiveRecord::Migration[7.0]
  def change
    add_column :messages, :send_to, :string
  end
end
