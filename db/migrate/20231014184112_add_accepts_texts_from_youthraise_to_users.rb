class AddAcceptsTextsFromYouthraiseToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :accepts_texts_from_youthraise, :boolean, default: false, null: false
  end
end
