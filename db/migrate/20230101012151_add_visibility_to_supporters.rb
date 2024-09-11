class AddVisibilityToSupporters < ActiveRecord::Migration[7.0]
  def change
    add_column :supporters, :visibility, :string
  end
end
