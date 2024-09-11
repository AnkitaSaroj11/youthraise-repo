class AddIndividualGoalToOrganizerSignups < ActiveRecord::Migration[7.0]
  def change
    add_column :organizer_signups, :individual_goal, :integer
  end
end
