class AddMessageToPersonalMessages < ActiveRecord::Migration[7.0]
  def change
    add_column :personal_messages, :message, :text
  end
end
