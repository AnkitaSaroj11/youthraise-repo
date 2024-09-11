class AddBodyToPersonalMessages < ActiveRecord::Migration[7.0]
  def change
    add_column :personal_messages, :body, :text
  end
end
