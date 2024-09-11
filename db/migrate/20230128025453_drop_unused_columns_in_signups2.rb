class DropUnusedColumnsInSignups2 < ActiveRecord::Migration[7.0]
  def change
    remove_column :organizer_signups, :purpose_more_info
    remove_column :organizer_signups, :purpose_other
  end
end
