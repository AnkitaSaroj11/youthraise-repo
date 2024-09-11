class MakeEmailTemplatesPolymorphic < ActiveRecord::Migration[7.0]
  def change
    add_column :email_templates, :templateable_id, :integer
    add_column :email_templates, :templateable_type, :string
    add_index :email_templates, [:templateable_type, :templateable_id]
    remove_column :campaign_members, :email_template_id
    remove_column :organizer_signups, :email_template_id
  end
end
