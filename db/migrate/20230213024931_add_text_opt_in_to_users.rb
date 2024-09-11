class AddTextOptInToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :text_preferences, :json
  end
end
