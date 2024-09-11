class AddTextMessageCountToMessages < ActiveRecord::Migration[7.0]
  def change
    add_column :messages, :texts_used, :integer
  end
end
